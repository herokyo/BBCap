//
//  DetailViewControllerTests.swift
//  BBCapTests
//
//  Created by Lam Le V. on 5/6/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Quick
import Nimble

@testable import BBCap

final class DetailViewControllerTests: QuickSpec {

    override func spec() {

        context("When init view controller") {

            var viewController: DetailViewController!

            beforeEach {
                viewController = DetailViewController()
                viewController.loadViewIfNeeded()
            }

            describe("Test frame for detail VC") {

                it("Frame subviews should be equal valid values") {
                    expect(viewController.navigationView.frame) == CGRect(x: 0, y: 20, width: 375, height: 54)
                    expect(viewController.currentCurrencyLabel.frame) == CGRect(x: 74.5, y: 0, width: 227.5, height: 18.0)
                    expect(viewController.hourPercentLabel.frame) == CGRect(x: 37, y: 0, width: 88, height: 12)
                    expect(viewController.dayPercentLabel.frame) == CGRect(x: 39, y: 0, width: 55.5, height: 12)
                    expect(viewController.weekPercentLabel.frame) == CGRect(x: 50.5, y: 0.0, width: 64.5, height: 12)
                    expect(viewController.lineChartView.frame) == CGRect(x: 0, y: 136, width: 375, height: 234)
                    expect(viewController.volumeViews[0].frame) == CGRect(x: 0, y: 406, width: 375, height: 34)
                    expect(viewController.volumeViews[1].frame) == CGRect(x: 0, y: 440, width: 375, height: 34)
                    expect(viewController.volumeViews[2].frame) == CGRect(x: 0, y: 474, width: 375, height: 34)
                    expect(viewController.volumeViews[3].frame) == CGRect(x: 0, y: 508, width: 375, height: 34)
                    expect(viewController.addAlertButton.frame) == CGRect(x: 10, y: 367, width: 167.5, height: 33)
                    expect(viewController.addToPortfolioButton.frame) == CGRect(x: 197.5, y: 367, width: 167.5, height: 33)
                }

                describe("Test content inset of line chat view") {

                    it("Extra Offset of chart view shoule equal value value") {
                        expect(viewController.lineChartView.viewPortHandler.offsetTop) == 4
                        expect(viewController.lineChartView.viewPortHandler.offsetLeft) == 0
                        expect(viewController.lineChartView.viewPortHandler.offsetRight) == 10
                        expect(viewController.lineChartView.viewPortHandler.offsetBottom) == 38.9609375
                        expect(viewController.lineChartView.minOffset) == -20
                        expect(viewController.lineChartView.extraTopOffset) == 4
                        expect(viewController.lineChartView.extraRightOffset) == 10
                        expect(viewController.lineChartView.extraBottomOffset) == -17
                        expect(viewController.lineChartView.extraLeftOffset) == 0
                    }
                }
            }
            afterEach {
                viewController = nil
            }
        }
    }
}
