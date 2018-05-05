//
//  BitcoinViewController.swift
//  BBCap
//
//  Created by Lam Le V. on 5/5/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
import SwifterSwift
import SwiftUtils

final class BitcoinViewController: ViewController {

    @IBOutlet private weak var navigationView: UIView!
    @IBOutlet private weak var currentCurrencyLabel: UILabel!
    @IBOutlet private weak var hourPercentLabel: UILabel!
    @IBOutlet private weak var dayPercentLabel: UILabel!
    @IBOutlet private weak var weekPercentLabel: UILabel!
    @IBOutlet private weak var oneWeekLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigationStatusBarView()
        configNavigationView()
    }

    private func configNavigationStatusBarView() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = Config.gradientColors
        gradientLayer.frame = Config.statusBarFrame
        view.layer.insertSublayer(gradientLayer, at: 0)
    }

    private func configNavigationView() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = navigationView.bounds
        gradientLayer.colors = Config.gradientColors
        navigationView.layer.insertSublayer(gradientLayer, at: 0)
    }
}

// MARK: - Config
extension BitcoinViewController {

    struct Config {
        static let bottomColor: UIColor! = UIColor(red: 17, green: 22, blue: 22)
        static let topColor: UIColor! = UIColor(red: 24, green: 19, blue: 32)
        static let gradientColors: [CGColor] = [Config.bottomColor.cgColor, Config.topColor.cgColor]
        static let statusBarHeight = UIApplication.shared.statusBarFrame.size.height
        static let statusBarFrame: CGRect = CGRect(x: 0, y: 0, width: 375, height: Config.statusBarHeight)
    }
}
