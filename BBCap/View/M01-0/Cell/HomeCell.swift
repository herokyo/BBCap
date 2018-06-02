//
//  HomeCell.swift
//  BBCap
//
//  Created by Hai Phung N.T. on 6/1/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

class HomeCell: UITableViewCell {

    struct Data {
        let index: Int
        let iconPath: String?
        let title: String?
        let cap: String?
        let value: String?
        let percent: String?
        let volumn: String?
    }

    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var capLabel: UILabel!
    @IBOutlet private weak var valueLabel: UILabel!
    @IBOutlet private weak var increaseLabel: UILabel!
    @IBOutlet private weak var volumeLabel: UILabel!
    @IBOutlet private weak var indexLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    var data: Data? {
        didSet {
            guard let data = data else { return }
            iconImageView.setImage(urlString: data.iconPath)
            titleLabel.text = data.title
            capLabel.text = data.cap
            valueLabel.text = data.value
            increaseLabel.text = data.percent
            volumeLabel.text = data.volumn
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
