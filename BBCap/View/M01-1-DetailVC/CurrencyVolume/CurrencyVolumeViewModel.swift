//
//  CurrencyVolumeViewModel.swift
//  BBCap
//
//  Created by Lam Le V. on 5/6/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

final class CurrencyVolumeViewModel {

    let volumeType: DetailViewModel.VolumeType?

    let priceType: PriceType?

    let ticket: Ticket?

    var title: String? {
        return volumeType?.title
    }

    var currency: String {
        guard let volumeType = volumeType, let ticket = ticket, let priceType = priceType else { return "" }
        switch volumeType {
        case .cap:
            switch priceType {
            case .btc:
                return ((ticket.marketCapUsd?.doubleValue).or(0) / ticket.usdOverBtc.or(1)).formatDecimal()
            case .eth:
                return ((ticket.marketCapUsd?.doubleValue).or(0) / ticket.usdOverEth.or(1)).formatDecimal()
            case .usd:
                return (ticket.marketCapUsd?.doubleValue.formatDecimal()).or("")
            }
        case .volume24h:
            switch priceType {
            case .btc:
                return ((ticket.volume24hUsd?.doubleValue).or(0) / ticket.usdOverBtc.or(1)).formatDecimal()
            case .eth:
                return ((ticket.volume24hUsd?.doubleValue).or(0) / ticket.usdOverEth.or(1)).formatDecimal()
            case .usd:
                return (ticket.volume24hUsd?.doubleValue.formatDecimal()).or("")
            }
        case .availableSupply:
            guard let availableSupply = ticket.availableSupply?.doubleValue.formatDecimal() else { return "" }
            return availableSupply + " " + ticket.symbol.unwrapped(or: "")
        case .totalSupply:
            guard let totalSupply = ticket.totalSupply?.doubleValue.formatDecimal() else { return "" }
            return totalSupply + " " + ticket.symbol.unwrapped(or: "")
        }
    }

    init(volumeType: DetailViewModel.VolumeType? = nil,
         ticket: Ticket? = nil,
         priceType: PriceType? = nil) {
        self.volumeType = volumeType
        self.ticket = ticket
        self.priceType = priceType
    }
}
