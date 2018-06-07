//
//  VirtualMoneyProtocolTests.swift
//  BBCapTests
//
//  Created by Lam Le V. on 6/5/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Quick
import Nimble

@testable import BBCap

final class VirtualMoneyProtocolTests: QuickSpec {

    override func spec() {

        var mockVirtualMoneys: [VirtualMoneyProtocol] = []

        context("When init `mockVirtualMoneys`") {

            beforeEach {
                mockVirtualMoneys = [MockBitcoin(), MockEthereum(), MockMoney()]
                mockVirtualMoneys.getUsdOverEth()
            }

            describe("Test default parameter") {

                it("`btcOverUsd`") {
                    expect(mockVirtualMoneys[0].usdOverBtc) == 100
                    expect(mockVirtualMoneys[1].usdOverBtc) == 250
                    expect(mockVirtualMoneys[2].usdOverBtc) == 200
                }

                it("`ethOverUsd`") {
                    expect(mockVirtualMoneys[0].usdOverEth) == 50
                    expect(mockVirtualMoneys[1].usdOverEth) == 50
                    expect(mockVirtualMoneys[2].usdOverEth) == 50
                }

                it("`priceEth`") {
                    expect(mockVirtualMoneys[0].priceEth) == 2
                    expect(mockVirtualMoneys[1].priceEth) == 1
                    expect(mockVirtualMoneys[2].priceEth) == 0.04
                }
            }
        }
    }
}
