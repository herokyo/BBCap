//
//  AddTransactionViewController.swift
//  BBCap
//
//  Created by Lam Le V. on 5/10/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
import SwifterSwift

final class AddTransactionViewController: ViewController {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var quantityTextField: UITextField!
    @IBOutlet private weak var priceTextField: UITextField!
    @IBOutlet private weak var dateTextField: UITextField!
    @IBOutlet private weak var denominationLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        configTextFields()
        configLabel()
    }

    private func configTextFields() {
        quantityTextField.addPaddingRightIcon(#imageLiteral(resourceName: "img_pen"), padding: Config.currencyPadding)
        priceTextField.addPaddingRightIcon(#imageLiteral(resourceName: "img_pen"), padding: Config.currencyPadding)
        dateTextField.addPaddingRightIcon(#imageLiteral(resourceName: "img_calendar"), padding: Config.calendarPadding)
    }

    private func configLabel() {
        let dolaAttributedString = NSAttributedString(string: "USD", attributes: [.foregroundColor: App.Color.bbGreenColor])
        let cointAttributedString = NSAttributedString(string: "/ETH/BTC", attributes: [.foregroundColor: UIColor.white])
        denominationLabel.attributedText = dolaAttributedString + cointAttributedString
    }

    // MARK: - IBAction
    @IBAction private func backButtonTouchUpInside(_ button: Button) {
        navigationController?.popViewController()
    }

    @IBAction private func saveTransactionButtonTouchUpInside(_ button: Button) {
        // TODO: - Push to detail VC to testing
        let vc = DetailViewController()
        navigationController?.pushViewController(vc)
    }
}

// MARK: - Dummy
extension AddTransactionViewController {

    struct Config {
        static let currencyPadding: CGFloat = 10
        static let calendarPadding: CGFloat = 15
    }
}
