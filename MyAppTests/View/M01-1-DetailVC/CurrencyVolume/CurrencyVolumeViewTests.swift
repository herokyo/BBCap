//
//  CurrencyVolumeViewTests.swift
//  BBCapTests
//
//  Created by Lam Le V. on 5/7/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Quick
import Nimble

@testable import BBCap

final class CurrencyVolumeViewTests: QuickSpec {

    override func spec() {

        context("When init cell") {

            var currencyVolumeView: CurrencyVolumeView!

            beforeEach {
                currencyVolumeView = CurrencyVolumeView(frame: CGRect(x: 0, y: 0, width: 375, height: 33))
                currencyVolumeView.awakeFromNib()
            }

            describe("Test frame of `CurrencyVolumeView`") {

                it("SubView frames should equal valid values") {
                    expect(currencyVolumeView.titleLabel.frame) == CGRect(x: 7, y: 7, width: 125, height: 20)
                    expect(currencyVolumeView.currencyLabel.frame) == CGRect(x: 132, y: 6.5, width: 235, height: 21)
                }
            }
        }
    }
}
