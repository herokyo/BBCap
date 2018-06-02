//
//  DetailViewModelTests.swift
//  BBCapTests
//
//  Created by Lam Le V. on 6/2/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Quick
import Nimble
import Foundation

@testable import BBCap

final class DetailViewModelTests: QuickSpec {

    override func spec() {

        var viewModel: DetailViewModel!

        context("When init view model") {

            beforeEach {
                viewModel = DetailViewModel()
            }

            context("When currency has valid value") {

                beforeEach {
                    viewModel.currency = Dummy.currency
                }

                it("dateString") {
                    viewModel.notifyForDate(entryX: 0)
                    expect(viewModel.dateString) == "May 31 2018 06:49:28"
                }

                it("price") {
                    viewModel.notifyForCurrencyAt(entryY: 9209.5799999999999)
                    expect(viewModel.price) == "$9,209.58"
                }
            }

            afterEach {
                viewModel = nil
            }
        }
    }
}

extension DetailViewModelTests {

    struct Dummy {

        static let currency: Currency = {
            let currency = Currency()
            currency.priceUSDs = [[1527724168000, 9209.5799999999999]]
            return currency
        }()
    }
}
