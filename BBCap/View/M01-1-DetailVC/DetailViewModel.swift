//
//  DetailViewModel.swift
//  BBCap
//
//  Created by Lam Le V. on 5/6/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import SwifterSwift
import SwiftDate
import Async

protocol DetailViewModelDelegate: class {
    func viewModelShouldUpdatePriceTypeButton(_ viewModel: DetailViewModel)
    func viewModelShouldUpdateDate(_ viewModel: DetailViewModel)
    func viewModelShouldUpdateCurrency(_ viewModel: DetailViewModel)
    func viewModelShouldUpdateChartView(_ viewModel: DetailViewModel)
}

final class DetailViewModel {

    var dateString = "" {
        didSet {
            delegate?.viewModelShouldUpdateDate(self)
        }
    }

    var price = "" {
        didSet {
            delegate?.viewModelShouldUpdateCurrency(self)
        }
    }

    var priceType: PriceType = .usd {
        didSet {
            ud.setValue(priceType.rawValue, forKey: UserDefaultsKey.priceType)
            delegate?.viewModelShouldUpdatePriceTypeButton(self)
            delegate?.viewModelShouldUpdateChartView(self)
        }
    }

    var timeIntervals: [Double] {
        switch priceType {
        case .eth, .btc:
            return []
        case .usd:
            return currency.priceUSDs.map { $0[0] }
        }
    }

    var prices: [Double] {
        switch priceType {
        case .eth, .btc:
            return []
        case .usd:
            return currency.priceUSDs.map { $0[1] }
        }
    }

    var axisPrices: [Double] {
        return prices.map { $0 - prices.min().unwrapped(or: 0) }
    }

    var axisMaximum: Double {
        return axisPrices.max().unwrapped(or: 0) * 1.1
    }

    var axisMinimum: Double {
        return -axisMaximum * 0.1
    }

    var currency = Currency()

    weak var delegate: DetailViewModelDelegate?

    let data: HomeCell.Data?

    init(data: HomeCell.Data? = nil) {
        self.data = data
        if let value = ud.value(forKey: UserDefaultsKey.priceType) as? String, let priceType = PriceType(rawValue: value) {
            self.priceType = priceType
        }
    }

    func volumeViewModel(withTag tag: Int) -> CurrencyVolumeViewModel {
        let volumeType = VolumeType(rawValue: tag)
        return CurrencyVolumeViewModel(volumeType: volumeType, ticket: data?.ticket)
    }

    // Notiffy for date and currency

    func notifyForDate(entryX: Int) {
        guard let timeIntervalMiliseconds = timeIntervals[safe: entryX] else { return }
        let timeInterval = timeIntervalMiliseconds / 1_000
        let date = Date(timeIntervalSince1970: TimeInterval(timeInterval))
        dateString = date.string(format: DateFormat.custom(Config.dateFormat))
    }

    func notifyForCurrencyAt(entryX: Int) {
        guard let priceFormat = prices[safe: entryX]?.formatCurrency() else { return }
        price = priceFormat
    }

    func notifyForGetCurrency(value: String, completion: @escaping ApiCompletion) {
        let timeType: TimeType! = TimeType(rawValue: value)
        Api.CoinmarketCap.getCurrencyBitcoin(type: timeType) { [weak self] result in
            guard let this = self else { return }
            Async.main {
                switch result {
                case .success(let value):
                    this.currency = value
                    this.notifyForDate(entryX: this.prices.count - 1)
                    this.notifyForCurrencyAt(entryX: this.prices.count - 1)
                    completion(.success)
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}

// MARK: Currency Type

extension DetailViewModel {

    enum PriceTypeError: Error {
        case invalid
    }

    enum PriceType: String {
        case usd = "USD"
        case btc = "BTC"
        case eth = "ETH"

        static func next(_ title: String?) throws -> PriceType {
            guard let title = title else { throw PriceTypeError.invalid }
            switch title {
            case "USD":
                return .btc
            case "BTC":
                return .eth
            case "ETH":
                return .usd
            default:
                throw PriceTypeError.invalid
            }
        }
    }
}

// MARK: TimeType

extension DetailViewModel {

    enum TimeType: String {
        case today = "Today"
        case oneWeek = "1W"
        case oneMonth = "1M"
        case threeMonth = "3M"
        case sixMonth = "6M"
        case oneYear = "1Y"
        case all = "All"

        var currentTimeInterval: Double {
            return Date().timeIntervalSince1970 * 1_000
        }

        var pastTimeInterval: Double {
            switch self {
            case .all:
                return 1_420_070_400_000 // Thursday, January 1, 2015 7:00:00 AM GMT+07:00, vietname's timezone
            default:
                return currentTimeInterval - duration * 1_000
            }
        }

        var duration: Double {
            switch self {
            case .today:
                return 86_400
            case .oneWeek:
                return TimeType.today.duration * 7
            case .oneMonth:
                return TimeType.today.duration * 30
            case .threeMonth:
                return TimeType.oneMonth.duration * 3
            case .sixMonth:
                return TimeType.oneMonth.duration * 6
            case .oneYear:
                return TimeType.today.duration * 365
            case .all:
                return 0
            }
        }
    }

}

// MARK: - Volume type
extension DetailViewModel {

    enum VolumeType: Int {
        case cap
        case volume24h
        case availableSupply
        case totalSupply

        var title: String {
            switch self {
            case .cap:
                return "Cap:"
            case .volume24h:
                return "Volume 24h:"
            case .availableSupply:
                return "Available Supply:"
            case .totalSupply:
                return "Total Supply:"
            }
        }

        // Dummy
        var currency: String {
            switch self {
            case .cap:
                return 162_337_461.956.formatCurrency(fraction: 3)
            case .volume24h:
                return 10_449_900.000.formatCurrency(fraction: 3)
            case .availableSupply:
                return 16_997_637.formatDecimal() + " BTC"
            case .totalSupply:
                return 16_997_637.formatDecimal() + " BTC"
            }
        }
    }
}

extension DetailViewModel {
    struct Config {
        static let dateFormat = "MMM dd yyyy HH:mm:ss"
    }
}
