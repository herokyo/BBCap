//
//  ApiExchangesTests.swift
//  BBCapTests
//
//  Created by Lam Le V. on 7/15/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Quick
import Nimble
import OHHTTPStubs

@testable import BBCap

final class ApiExchangesTests: QuickSpec {
    
    override func spec() {

        describe("Test api exchanges") {

            context("Api should return success value which status code 201") {

                beforeEach {
                    let data = Data(forResource: "ApiExchanges", ofType: "json", on: self)
                    stub(condition: isPath("/api/v1/exchanges")) { _ in
                        return OHHTTPStubsResponse(data: data, statusCode: 200, headers: .none)
                    }
                }

                it("Result should return success value") {
                    waitUntil(timeout: timeOut) { done in
                        Api.Exchanges.getList { result in
                            let exchange = result.value?.first
                            expect(exchange?.id) == "5b1336aa65d4403aaf1ca822"
                            expect(exchange?.name) == "BINANCE"
                            expect(exchange?.position) == 0
                            expect(exchange?.iconPath) == "http://localhost/img/exchanges/binance.png"
                            expect(exchange?.website) == "https://www.binance.com"
                            expect(exchange?.chat) == "https://t.me/binanceexchange"
                            expect(exchange?.twitter) == "https://twitter.com/binance"
                            expect(exchange?.symbol) == "BINANCE"
                            done()
                        }
                    }
                }
            }
        }
    }
}


