//
//  AppDelegate.swift
//  BBCap
//
//  Created by iOSTeam on 2/21/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
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
        configIQKeyboard()
//        window = UIWindow(frame: UIScreen.main.bounds)
//        if let window = window {
//            window.rootViewController = MenuVC.vc()
//            window.makeKeyAndVisible()
//        }
        return true
    }
}

extension AppDelegate {

    fileprivate func configIQKeyboard() {
        IQKeyboardManager.sharedManager().enable = true
    }

    fileprivate func configNetwork() {
        networkIndicator.isEnabled = true
        networkIndicator.startDelay = 0
    }
}
