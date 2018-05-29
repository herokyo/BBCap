//
//  APIResigterTests.swift
//  BBCapTests
//
//  Created by Lam Le V. on 5/29/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Quick
import Nimble
import OHHTTPStubs

@testable import BBCap

final class APIResigterTests: QuickSpec {

    override func spec() {

        describe("Test api users") {

            context("Api should return success value which status code 201") {

                beforeEach {
                    let data = Data(forResource: "ApiToken", ofType: "json", on: self)
                    stub(condition: isPath("/api/v1/users")) { _ in
                        return OHHTTPStubsResponse(data: data, statusCode: 201, headers: .none)
                    }
                }

                it("Result should return success value") {
                    let apiUsers = Api.Register()
                    waitUntil(timeout: timeOut) { done in
                        apiUsers.token { result in
                            expect(result.value) == "e81935652cc8c654285ce1eea5657c5ff1de8ad9309ccc08df83538761a64679"
                            done()
                        }
                    }
                }
            }

            context("Api should return maintenance error") {

                beforeEach {
                    let data = Data(forResource: "ErrorResponse", ofType: "json", on: self)
                    stub(condition: isPath("/api/v1/users")) { _ in
                        return OHHTTPStubsResponse(data: data, statusCode: 503, headers: .none)
                    }
                }

                it("Response should return errors") {
                    let apiUsers = Api.Register()
                    waitUntil(timeout: timeOut) { done in
                        apiUsers.token { result in
                            expect(result.error?.code) == 503
                            expect(result.error?.localizedDescription) == "The error content message"
                            done()
                        }
                    }
                }
            }

            afterEach {
                OHHTTPStubs.removeAllStubs()
            }
        }
    }
}
