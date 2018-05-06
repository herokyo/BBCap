//
//  ApiManagerTests.swift
//  BBCapTests
//
//  Created by Le Van Lam on 4/28/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Quick
import Nimble
import OHHTTPStubs

@testable import BBCap

final class ApiManagerTests: QuickSpec {

    override func spec() {

        describe("Test api core request") {

            context("When api has response and status code is 200") {

                beforeEach {
                    stub(condition: isPath(Dummy.myWebService)) { _ in
                        return OHHTTPStubsResponse(jsonObject: Dummy.successResponse, statusCode: 200, headers: nil)
                    }
                }

                it("Result should return success value") {
                    waitUntil(timeout: timeOut) { done in
                        api.request(urlString: Dummy.myWebService) { result in
                            guard let value = result.value as? [String: Any] else {
                                fail()
                                return
                            }
                            expect(value["response"] as? String) == "ok"
                            done()
                        }
                    }
                }
            }

            context("When api has response and status code is 204") {

                beforeEach {
                    stub(condition: isPath(Dummy.myWebService)) { _ in
                        return OHHTTPStubsResponse(jsonObject: Dummy.successResponse, statusCode: 204, headers: nil)
                    }
                }

                it("Result should return empty data") {
                    waitUntil(timeout: timeOut) { done in
                        api.request(urlString: Dummy.myWebService) { result in
                            guard let value = result.value as? [String: Any] else {
                                fail("Force cast error")
                                return
                            }
                            expect(value.isEmpty) == true
                            done()
                        }
                    }
                }
            }

            context("When network is low") {

                beforeEach {
                    let error = NSError(code: -1_001, message: "low network")
                    stub(condition: isPath(Dummy.myWebService)) { _ in
                        return OHHTTPStubsResponse(error: error)
                    }
                }

                it("Result should return error with code -1001") {
                    waitUntil(timeout: timeOut) { done in
                        api.request(urlString: Dummy.myWebService) { result in
                            expect(result.error?.code) == -1_001
                            done()
                        }
                    }
                }
            }

            context("When network is low") {

                beforeEach {
                    stub(condition: isPath(Dummy.myWebService)) { _ in
                        return OHHTTPStubsResponse(jsonObject: [:], statusCode: 500, headers: nil)
                    }
                }

                it("Result should return error 500") {
                    waitUntil(timeout: timeOut) { done in
                        api.request(urlString: Dummy.myWebService) { result in
                            expect(result.error?.code) == 500
                            done()
                        }
                    }
                }
            }

            context("When api has big status code") {

                beforeEach {
                    stub(condition: isPath(Dummy.myWebService)) { _ in
                        return OHHTTPStubsResponse(jsonObject: [:], statusCode: 2_000, headers: nil)
                    }
                }

                it("Result should return error which code is 976") {
                    waitUntil(timeout: timeOut) { done in
                        api.request(urlString: Dummy.myWebService) { result in
                            expect(result.error?.code) == 976
                            expect(result.error?.localizedDescription) == "Unknown HTTP status code received (976)."
                            done()
                        }
                    }
                }
            }

            context("When api has error response and status code is 200") {

                beforeEach {
                    let data = Data(forResource: "JsonFailure", ofType: "json", on: self)
                    stub(condition: isPath(Dummy.myWebService)) { _ in
                        return OHHTTPStubsResponse(data: data, statusCode: 200, headers: nil)
                    }
                }

                it("Result should return json error") {
                    waitUntil(timeout: timeOut) { done in
                        api.request(urlString: Dummy.myWebService) { result in
                            expect(result.error?.code) == Api.Error.json.code
                            expect(result.error?.localizedDescription) == Api.Error.json.localizedDescription
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

// MARK: - Dummy
extension ApiManagerTests {

    struct Dummy {
        static let myWebService = "www.myWebService.com"
        static let successResponse: [String: Any] = [
            "response": "ok"
        ]
    }
}
