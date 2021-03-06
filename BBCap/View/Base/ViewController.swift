//
//  ViewController.swift
//  BBCap
//
//  Created by iOSTeam on 2/21/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
import MVVM

class ViewController: UIViewController, MVVM.View {

    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavigationBar()
    }

    private func hideNavigationBar() {
        navigationController?.isNavigationBarHidden = true
    }
}
