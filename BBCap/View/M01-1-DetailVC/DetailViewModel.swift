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
import Font_Awesome_Swift
import AwesomeEnum

protocol DetailViewModelProtocol {
    var iconPath: String? { get }
    var currencyName: String? { get }
    var isStarSelected: Bool { get set }
    var currentPrice: String { get }
    var priceTypeName: String? { get set }
    var percentHour: String? { get }
    var percentDay: String? { get }
    var percentWeek: String? { get }
    var chartCurrency: String { get }
    var chartDateString: String { get }
}

protocol DetailViewModelDelegate: class {
    func viewModelShouldUpdateVolumeViews(_ viewModel: DetailViewModel)
    func viewModelShouldUpdateCurrentCurrency(_ viewModel: DetailViewModel)
    func viewModelShouldUpdatePriceTypeButton(_ viewModel: DetailViewModel)
    func viewModelShouldUpdateDate(_ viewModel: DetailViewModel)
    func viewModelShouldUpdateCurrency(_ viewModel: DetailViewModel)
    func viewModelShouldUpdateChartView(_ viewModel: DetailViewModel)
}

final class DetailViewModel: DetailViewModelProtocol {

    var isStarSelected: Bool = false

    var iconPath: String? {
        return data?.iconPath
    }

    var currencyName: String? {
        return data?.title
    }

    var currentPrice: String {
        return (prices[safe: prices.count - 1]?.formatDecimal(minimum: 0, maximum: 8)).or("")
    }

    var priceTypeName: String? {
        get {
            guard let name = ud.value(forKey: UserDefaultsKey.priceType) as? String else { return "USD" }
            return name
        }
        set {
            ud.setValue(newValue, forKey: UserDefaultsKey.priceType)
        }
    }

    var percentHour: String? {
        return data?.percentChange1h
    }

    var percentDay: String? {
        return data?.percentChange24h
    }

    var percentWeek: String? {
        return data?.percentChange7d
    }

    var chartCurrency: String = "" {
        didSet {
            delegate?.viewModelShouldUpdateCurrency(self)
        }
    }

    var chartDateString: String = "" {
        didSet {
            delegate?.viewModelShouldUpdateDate(self)
        }
    }

    var priceType: PriceType = .usd {
        didSet {
            priceTypeName = priceType.rawValue
            delegate?.viewModelShouldUpdateCurrency(self)
            delegate?.viewModelShouldUpdateVolumeViews(self)
            delegate?.viewModelShouldUpdateCurrentCurrency(self)
            delegate?.viewModelShouldUpdatePriceTypeButton(self)
        }
    }

    var timeIntervals: [Double] {
        return currency.priceUSDs.map { $0[0] }
    }

    var prices: [Double] {
        switch priceType {
        case .btc:
            return currency.priceBTCs.map { $0[1] }
        case .eth:
            return currency.priceUSDs.map { $0[1] / (data?.ticket.usdOverEth).or(1) }
        case .usd:
            return currency.priceUSDs.map { $0[1] }
        }
    }

    var axisPrices: [Double] {
        let prices = currency.priceUSDs.map { $0[1] }
        return prices.map { $0 - prices.min().unwrapped(or: 0) }
    }

    var axisMaximum: Double {
        return axisPrices.max().unwrapped(or: 0) * 1.1
    }

    var axisMinimum: Double {
        return -axisMaximum * 0.1
    }

    var isNegativeHourPercent: Bool {
        return (data?.ticket.isNegativeChange1h).or(else: false)
    }

    var isNegativeDayPercent: Bool {
        return (data?.ticket.isNegativeChange24h).or(else: false)
    }

    var isNegativePercentWeek: Bool {
        return (data?.ticket.isNegativeChange7d).or(else: false)
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
        return CurrencyVolumeViewModel(volumeType: volumeType, ticket: data?.ticket, priceType: priceType)
    }

    func next(_ title: String) -> PriceType? {
        switch title {
        case "USD":
            return .btc
        case "BTC":
            return .eth
        case "ETH":
            return .usd
        default:
            return nil
        }
    }

    // Notiffy for date and currency

    func notifyForDate(entryX: Int) {
        guard let timeIntervalMiliseconds = timeIntervals[safe: entryX] else { return }
        let timeInterval = timeIntervalMiliseconds / 1_000
        let date = Date(timeIntervalSince1970: TimeInterval(timeInterval))
        chartDateString = date.string(format: DateFormat.custom(Config.dateFormat))
    }

    func notifyForCurrencyAt(entryX: Int) {
        guard let priceFormat = prices[safe: entryX]?.formatDecimal(minimum: 0, maximum: 8) else { return }
        chartCurrency = priceFormat
    }

    func notifyForGetCurrency(value: String, completion: @escaping ApiCompletion) {
        let timeType: TimeType! = TimeType(rawValue: value)
        Api.CoinmarketCap.getCurrencyBitcoin(type: timeType, currency: (data?.ticket.id).or("")) { [weak self] result in
            guard let this = self else { return }
            Async.main {
                switch result {
                case .success(let value):
                    this.currency = value
                    this.notifyForDate(entryX: this.prices.count - 1)
                    this.notifyForCurrencyAt(entryX: this.prices.count - 1)
                    this.delegate?.viewModelShouldUpdateCurrentCurrency(this)
                    completion(.success)
                case .failure(let error):
                    completion(.failure(error))
                }
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
    }
}

extension DetailViewModel {
    struct Config {
        static let dateFormat = "MMM dd yyyy HH:mm:ss"
    }
}
