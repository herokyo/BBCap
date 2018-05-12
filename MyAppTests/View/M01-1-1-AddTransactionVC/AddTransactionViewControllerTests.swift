//
//  AddTransactionViewControllerTests.swift
//  BBCapTests
//
//  Created by Lam Le V. on 5/12/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Quick
import Nimble

@testable import BBCap

final class AddTransactionViewControllerTests: QuickSpec {
    
    override func spec() {

        context("When init view controller") {

            var vc: AddTransactionViewController!

            beforeEach {
                vc = AddTransactionViewController()
                vc.loadViewIfNeeded()
            }

            describe("Test frame") {

                it("Frame subviews should be equal valid values") {
                    expect(vc.titleLabel.frame) == CGRect(x: 40.0, y: 16.5, width: 183.5, height: 21.5)
                }
            }
        }
    }
    
}
