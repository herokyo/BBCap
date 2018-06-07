//
//  MockVirtualMoneyProtocol.swift
//  BBCap
//
//  Created by Lam Le V. on 6/5/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
@testable import BBCap

final class MockBitcoin: VirtualMoneyProtocol {

    var id: String? {
        return "bitcoin"
    }

    var priceBtc: String? {
        return "1"
    }

    var priceUsd: String? {
        return "100"
    }
}

final class MockEthereum: VirtualMoneyProtocol {

    var priceBtc: String? {
        return "0.2"
    }

    var id: String? {
        return "ethereum"
    }

    var priceUsd: String? {
        return "50"
    }
}

final class MockMoney: VirtualMoneyProtocol {

    var priceBtc: String? {
        return "0.01"
    }

    var id: String? {
        return "MockMoney"
    }

    var priceUsd: String? {
        return "2"
    }
}

