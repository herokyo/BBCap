//
//  Measurement.swift
//  BBCap
//
//  Created by Lam Le V. on 6/3/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

final class Measurement {

    var btcToUsd = 1.0
    var ethToUsd = 1.0

    init?(tickets: [Ticket]) {
        let btcs = tickets.filter { $0.id == "bitcoin" }
        let eths = tickets.filter { $0.id == "ethereum" }
        guard let eth = eths.first, let btc = btcs.first else { return nil }
        btcToUsd = (btc.priceUsd?.doubleValue).or(1)
        ethToUsd = (eth.priceUsd?.doubleValue).or(1)
    }
}
