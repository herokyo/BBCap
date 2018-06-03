//
//  BBTabbarController.swift
//  BBCap
//
//  Created by MBA0105 on 5/6/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
import Font_Awesome_Swift

final class BBTabbarController: UITabBarController, StoryboardIdentifiable {

    enum ItemType: Int {
        case marketCap, watchList, portfolio, ideas

        var itemInfo: (title: String?, iconType: FAType) {
            switch self {
            case .marketCap: return (title: "Market Cap", iconType: .FABitcoin)
            case .watchList: return (title: "WatchList", iconType: .FABarChart)
            case .portfolio: return (title: "Porfolio", iconType: .FAUser)
            case .ideas: return (title: "Ideas", iconType: .FALightbulbO)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        var index = 0
        viewControllers?.forEach({ (vc) in
            if let itemType = ItemType(rawValue: index) {
                let image = UIImage(icon: itemType.itemInfo.iconType, size: App.Size.icon, textColor: .white)
                vc.tabBarItem = UITabBarItem(title: itemType.itemInfo.title, image: image, selectedImage: nil)
            }
            index += 1
        })
    }
}
