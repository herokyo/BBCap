//
//  CreateAlertViewController.swift
//  BBCap
//
//  Created by Lam Le V. on 5/12/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
import SwifterSwift

final class CreateAlertViewController: ViewController {

    @IBOutlet private weak var selectExchangeTextField: UITextField!
    @IBOutlet private weak var selectMarketTextField: UITextField!
    @IBOutlet private weak var minusButton: UIButton!
    @IBOutlet private weak var plusButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        configTextFields()
        configButtons()
        updateView()
    }

    private func configTextFields() {
        selectExchangeTextField.addPaddingRightIcon(#imageLiteral(resourceName: "img_pen"), padding: Config.padding)
        selectMarketTextField.addPaddingRightIcon(#imageLiteral(resourceName: "img_pen"), padding: Config.padding)
    }

    private func configButtons() {
        minusButton.backgroundColor = Config.buttonColor
        plusButton.backgroundColor = Config.buttonColor
    }

    private func updateView() {
        // TODO: Dummy Data
        let coinAttributedString = NSAttributedString(string: "BTC", attributes: [.foregroundColor: UIColor.white])
        let dolaAttributedString = NSAttributedString(string: "/USD", attributes: [.foregroundColor: Config.brownColor])
        selectMarketTextField.attributedText = coinAttributedString + dolaAttributedString

        selectExchangeTextField.text = "CoinMarket"
    }

    // MARK: - IBAction
    @IBAction private func changePriceButtonTouchUpInside(_ button: Button) {
        // TODO: Handle price later
    }

    @IBAction private func saveAlertButtonTouchUpInside(_ button: UIButton) {
    }
}

// MARK: - Define
extension CreateAlertViewController {

    struct Config {
        static let padding: CGFloat = 10
        static let brownColor: UIColor! = UIColor(red: 128, green: 128, blue: 128)
        static let buttonColor: UIColor! = UIColor(red: 27, green: 24, blue: 40)
    }
}
