//
//  SideMenuController.swift
//  BBCap
//
//  Created by MBA0105 on 5/6/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
import LGSideMenuController

final class SideMenuController: LGSideMenuController, StoryboardIdentifiable {

    static var shared: SideMenuController!

    override func viewDidLoad() {
        super.viewDidLoad()
        configSideMenu()
    }

    private func configSideMenu() {

        leftViewWidth = UIScreen.main.bounds.width - 80
        leftViewController?.view.clipsToBounds = true

        let menuVC: MenuVC = UIStoryboard.main.instantiateViewController()
        leftViewController = menuVC

        let tabbar: BBTabbarController = UIStoryboard.main.instantiateViewController()
        rootViewController = tabbar

        SideMenuController.shared = self
    }
}
