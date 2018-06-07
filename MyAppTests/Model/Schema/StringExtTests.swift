//
//  CalculationProtocolTests.swift
//  BBCapTests
//
//  Created by Lam Le V. on 6/6/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Quick
import Nimble

@testable import BBCap

final class StringExtTests: QuickSpec {

    override func spec() {

        describe("Test correctly") {

            it("`plus`") {
                expect { try "1".plus("2") } == "3"
                expect { try "1.0".plus("2.0") } == "3"
                expect { try "1.3".plus("2.4") } == "3.7"
                expect { try "1.1111".plus("2") } == "3.1111"
                expect { try "1.099".plus("2.001") } == "3.1"
                expect { try "1.439493434".plus("25.423232323") } == "26.862725757"
            }

            it("`minus`") {
                expect { try "1".minus("2") } == "-1"
                expect { try "0".minus("2") } == "-2"
                expect { try "-1.334".minus("2.00393") } == "-3.33793"
                expect { try "1".minus("2.333") } == "-1.333"
                expect { try "1000000".minus("1") } == "999999"
                expect { try "-1.33223".minus("-2.33") } == "0.99777"
            }

            it("`multiplier`") {
                expect { try "1".multiplier("2") } == "2"
                expect { try "1.0".multiplier("2.0") } == "2"
                expect { try "1.3".multiplier("2.4") } == "3.12"
                expect { try "-1.1111".multiplier("2") } == "-2.2222"
                expect { try "1.099".multiplier("2.001") } == "2.199099"
            }

            it("`device`") {
                expect { try "1".divide("2") } == "0.5"
                expect { try "1".divide("3") } == "0.333333333333333"
            }
        }

        it("Test Error") {
            expect { try "a".plus("1") }.to(throwError(String.Invalid.numerator))
            expect { try "1".plus("a") }.to(throwError(String.Invalid.denominator))
            expect { try "==0".minus("11") }.to(throwError(String.Invalid.numerator))
            expect { try "a".minus("1") }.to(throwError(String.Invalid.numerator))
            expect { try "a".minus("abc") }.to(throwError(String.Invalid.denominator))
            expect { try "a".multiplier("1") }.to(throwError(String.Invalid.numerator))
            expect { try "a".multiplier("1") }.to(throwError(String.Invalid.numerator))
            expect { try "1".multiplier("a") }.to(throwError(String.Invalid.denominator))
            expect { try "1".divide("0") }.to(throwError(String.Invalid.divideForZero))
            expect { try "2".divide("b") }.to(throwError(String.Invalid.denominator))
            expect { try "1".divide("ss") }.to(throwError(String.Invalid.denominator))
            expect { try "423".divide("??--0792739") }.to(throwError(String.Invalid.denominator))
        }
    }
}
