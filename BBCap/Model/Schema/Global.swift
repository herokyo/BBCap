//
//  Global.swift
//  BBCap
//
//  Created by Hai Phung N.T. on 6/2/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import ObjectMapper

final class Global: Mappable {

    var activeAssets: Int = 0
    var activeCurrencies: Int = 0
    var activeMarkets: Int = 0
    var bitcoinPercentageOfMarketCap: Float = 0
    var lastUpdated: Int = 1514764800
    var total24hVolumeUsd: Int = 0
    var totalMarketCapUsd: Int = 0

    class func newInstance(map: Map) -> Mappable? {
        return Global()
    }
    required init?(map: Map) { }
    init() { }

    func mapping(map: Map) {
        activeAssets <- map["active_assets"]
        activeCurrencies <- map["active_currencies"]
        activeMarkets <- map["active_markets"]
        bitcoinPercentageOfMarketCap <- map["bitcoin_percentage_of_market_cap"]
        lastUpdated <- map["last_updated"]
        total24hVolumeUsd <- map["total_24h_volume_usd"]
        totalMarketCapUsd <- map["total_market_cap_usd"]

    }
}
