//
//  VirtualMoneyProtocol.swift
//  BBCap
//
//  Created by Lam Le V. on 6/6/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

private struct VirtualMoneyKey {
    static var usdOverEth = "usdOverEth"
}

protocol VirtualMoneyProtocol: class {
    var id: String? { get }
    var usdOverBtc: Double? { get }
    var usdOverEth: Double? { get }
    var priceUsd: String? { get }
    var priceBtc: String? { get }
    var priceEth: Double? { get }
}

extension VirtualMoneyProtocol {

    var usdOverBtc: Double? {
        guard let priceUsd = priceUsd?.double(), abs(priceUsd) > 0, let priceBtc = priceBtc?.double() else { return nil }
        return priceUsd / priceBtc
    }

    var usdOverEth: Double? {
        set {
            objc_setAssociatedObject(self, &VirtualMoneyKey.usdOverEth, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
        get {
            return objc_getAssociatedObject(self, &VirtualMoneyKey.usdOverEth) as? Double
        }
    }

    var priceEth: Double? {
        guard let priceUsd = priceUsd?.double(), let usdOverEth = usdOverEth else { return nil }
        return priceUsd / usdOverEth
    }
}

extension Collection where Element == VirtualMoneyProtocol {

    func getUsdOverEth() {
        let priceStringUsd = filter { $0.id == "ethereum" }.first?.priceUsd
        guard let priceUsd = priceStringUsd?.double(), abs(priceUsd) > 0 else { return }
        forEach { $0.usdOverEth = priceUsd }
    }
}

extension Ticket: VirtualMoneyProtocol { }
