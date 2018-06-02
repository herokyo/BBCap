//
//  ApiCoinmarketcapTests.swift
//  BBCapTests
//
//  Created by Lam Le V. on 6/1/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Quick
import Nimble
import OHHTTPStubs

@testable import BBCap

final class ApiCoinmarketcapTests: QuickSpec {

    override func spec() {

        context("Test response success") {

            beforeEach {
                let data = Data(forResource: "CoinMarketcap", ofType: "json", on: self)
                stub(condition: isPath("/currencies/bitcoin/1527613347562/1527699747562")) { _ in
                    return OHHTTPStubsResponse(data: data, statusCode: 200, headers:
                    .none)
                }
            }

//            it("Response should return success value") {
//                waitUntil(timeout: timeOut) { done in
//                    Api.CoinmarketCap.getCurrencyBitcoin { result in
//                        switch result {
//                        case .success(let value):
//                            let marketCap = value.marketCaps.first
//                            expect(marketCap?[0]) == 1527613474000
//                            expect(marketCap?[1]) == 127066760056
//
//                            let priceUTC = value.priceBTCs.first
//                            expect(priceUTC?[0]) == 1527613474000
//                            expect(priceUTC?[1]) == 1
//
//                            let priceUSD = value.priceUSDs.first
//                            expect(priceUSD?[0]) == 1527613474000
//                            expect(priceUSD?[1]) == 7447.24
//
//                            let volumeUSD = value.volumeUSDs.first
//                            expect(volumeUSD?[0]) == 1527613474000
//                            expect(volumeUSD?[1]) == 5552870000
//
//                        case .failure(let error):
//                            fail(error.localizedDescription)
//                        }
//                        done()
//                    }
//                }
//            }
        }
    }
}

