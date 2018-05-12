//
//  AppDelegate.swift
//  BBCap
//
//  Created by iOSTeam on 2/21/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
import AlamofireNetworkActivityIndicator

let networkIndicator = NetworkActivityIndicatorManager.shared

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    static let shared: AppDelegate = {
        guard let shared = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Cannot cast `UIApplication.shared.delegate` to `AppDelegate`.")
        }
        return shared
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        configNetwork()
        configWindow(type: .addTransactionVC)
        return true
    }
}

extension AppDelegate {

    fileprivate func configNetwork() {
        networkIndicator.isEnabled = true
        networkIndicator.startDelay = 0
    }

    // MARK: - Config window
    private func configWindow(type: VCType = .detailVC) {
        window = UIWindow(frame: UIScreen.main.bounds)
        guard let window = window else { return }
        var vc: ViewController!
        switch type {
        case .addTransactionVC:
            vc = AddTransactionViewController()
        case .detailVC:
            vc = DetailViewController()
        }
        let navigationController = UINavigationController(rootViewController: vc)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}

// TODO: - Will remove later
extension AppDelegate {

    enum VCType {
        case detailVC
        case addTransactionVC
    }
}
