//
//  HomeVC.swift
//  BBCap
//
//  Created by MBA0105 on 5/6/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
import Font_Awesome_Swift

class HomeVC: UIViewController, StoryboardIdentifiable {

    @IBOutlet private weak var menuButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        menuButton.setImage(UIImage(icon: FAType.FANavicon, size: CGSize(size: 34)), for: .normal)
    }

    @IBAction func menuButtonTouchUpInside(_ sender: UIButton?) {
        SideMenuController.shared.showLeftViewAnimated()
    }
}
