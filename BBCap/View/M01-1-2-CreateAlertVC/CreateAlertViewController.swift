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

    @IBOutlet private weak var selectMarketButton: Button!
    @IBOutlet private weak var minusButton: UIButton!
    @IBOutlet private weak var plusButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }

    private func configView() {
        minusButton.backgroundColor = Config.buttonColor
        plusButton.backgroundColor = Config.buttonColor

        let coinAttributedString = NSAttributedString(string: "BTC", attributes: [.foregroundColor: UIColor.white])
        let dolaAttributedString = NSAttributedString(string: "/USD", attributes: [.foregroundColor: Config.brownColor])
        selectMarketButton.setAttributedTitle(coinAttributedString + dolaAttributedString, for: .normal)
    }

    // MARK: - IBAction
    @IBAction private func changePriceButtonTouchUpInside(_ button: Button) {
    }

    @IBAction private func saveAlertButtonTouchUpInside(_ button: UIButton) {
    }

    @IBAction private func backButtonTouchUpInside(_ button: Button) {
        navigationController?.popViewController()
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
