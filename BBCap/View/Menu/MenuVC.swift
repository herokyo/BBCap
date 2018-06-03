//
//  MenuVC.swift
//  BBCap
//
//  Created by MBA0105 on 5/6/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
import Font_Awesome_Swift

final class MenuVC: UITableViewController, StoryboardIdentifiable {

    enum RowType: Int {
        case store, setting, about, feedback

        var title: String? {
            return ["Store", "Setting", "About", "Feedback"][safe: hashValue]
        }

        var icon: UIImage? {
            let size = App.Size.icon
            return [UIImage(icon: FAType.FAShoppingCart, size: size, textColor: .white),
                UIImage(icon: FAType.FACog, size: size, textColor: .white),
                UIImage(icon: FAType.FAInfo, size: size, textColor: .white),
                UIImage(icon: FAType.FARssSquare, size: size, textColor: .white)][safe: hashValue]
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RowType.caseCount
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let rowType = RowType(rawValue: indexPath.row), let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell") as? MenuCell else { fatalError() }
        cell.iconImageView.image = rowType.icon
        cell.titleLabel.text = rowType.title
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        SideMenuController.shared.hideLeftViewAnimated()
    }
}
