//
//  AppDelegate.swift
//  BBCap
//
//  Created by iOSTeam on 2/21/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
import AlamofireNetworkActivityIndicator
import IQKeyboardManagerSwift

let networkIndicator = NetworkActivityIndicatorManager.shared
let ud = UserDefaults.standard

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
        configIQKeyBoardManager()
        register()
        UIApplication.shared.isStatusBarHidden = true
        return true
    }

    // TODO: register
    private func register() {
        guard Session.shared.token.isEmpty else { return }
        Api.Register.token { result in
            switch result {
            case .success(let value):
                Session.shared.token = value
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension AppDelegate {

    fileprivate func configNetwork() {
        networkIndicator.isEnabled = true
        networkIndicator.startDelay = 0
    }

    private func configIQKeyBoardManager() {
        IQKeyboardManager.shared.enable = true
    }
}
