//
//  Currency.swift
//  BBCap
//
//  Created by Lam Le V. on 6/1/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import ObjectMapper

protocol CurrencyProtocol {
    associatedtype Element
    var marketCaps: [Element] { get }
    var priceBTCs: [Element] { get }
    var priceUSDs: [Element] { get }
    var volumeUSDs: [Element] { get }
}

typealias CurrencyValue = [Double]

final class Currency: Mappable, CurrencyProtocol {

    typealias Element = CurrencyValue

    var marketCaps: [CurrencyValue] = []

    var priceBTCs: [CurrencyValue] = []

    var priceUSDs: [CurrencyValue] = []

    var volumeUSDs: [CurrencyValue] = []

    init?(map: Map) {
    }

    init() {}

    func mapping(map: Map) {
        marketCaps <- map["market_cap_by_available_supply"]
        priceBTCs <- map["price_btc"]
        priceUSDs <- map["price_usd"]
        volumeUSDs <- map["volume_usd"]
    }
}
