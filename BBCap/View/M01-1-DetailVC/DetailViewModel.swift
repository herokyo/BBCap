//
//  DetailViewModel.swift
//  BBCap
//
//  Created by Lam Le V. on 5/6/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

final class DetailViewModel {

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
                return 162_337_461_956.formatCurrency()
            case .volume24h:
                return 10_449_900_000.formatCurrency()
            case .availableSupply:
                return 16_997_637.formatDecimal() + " BTC"
            case .totalSupply:
                return 16_997_637.formatDecimal() + " BTC"
            }
        }
    }

    func volumeViewModel(withTag tag: Int) -> CurrencyVolumeViewModel {
        let volumeType = VolumeType(rawValue: tag)
        return CurrencyVolumeViewModel(volumeType: volumeType)
    }
}
