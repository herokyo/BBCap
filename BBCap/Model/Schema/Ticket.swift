//
//  Coin.swift
//  BBCap
//
//  Created by Hai Phung N.T. on 6/2/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

//
//    Coin.swift
//
//    Create by Hai Phung Nguyen Thanh on 2/6/2018
//    Copyright © 2018. All rights reserved.
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation
import ObjectMapper
import SwifterSwift

final class Ticket: Mappable {

    var volume24hUsd: String?
    var availableSupply: String?
    var id: String?
    var lastUpdated: String?
    var marketCapUsd: String?
    var maxSupply: AnyObject?
    var name: String?
    var percentChange1h: String?
    var percentChange24h: String?
    var percentChange7d: String?
    var priceBtc: String?
    var priceUsd: String?
    var rank: String?
    var symbol: String?
    var totalSupply: String?

    var marketCapUsdInt: Int {
        return marketCapUsd.or("").doubleValue.int
    }

    var volume24hUsdInt: Int {
        return volume24hUsd.or("").doubleValue.int
    }

    class func newInstance(map: Map) -> Mappable? {
        return Ticket()
    }
    init?(map: Map) { }

    init() { }

    func mapping(map: Map) {
        volume24hUsd <- map["24h_volume_usd"]
        availableSupply <- map["available_supply"]
        id <- map["id"]
        lastUpdated <- map["last_updated"]
        marketCapUsd <- map["market_cap_usd"]
        maxSupply <- map["max_supply"]
        name <- map["name"]
        percentChange1h <- map["percent_change_1h"]
        percentChange24h <- map["percent_change_24h"]
        percentChange7d <- map["percent_change_7d"]
        priceBtc <- map["price_btc"]
        priceUsd <- map["price_usd"]
        rank <- map["rank"]
        symbol <- map["symbol"]
        totalSupply <- map["total_supply"]
    }
}
