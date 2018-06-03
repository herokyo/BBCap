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
        let percentChange1h: String?
        let percentChange24h: String?
        let percentChange7d: String?
        let volumn: String?
        let ticket: Ticket

        init(ticket: Ticket, index: Int) {
            self.index = index
            iconPath = "https://coinmarket.zone/images/64x64/\(ticket.id.or("")).png"
            title = "\(ticket.name.or("")) - \(ticket.symbol.or(""))"
            cap = "Cap: $\(ticket.marketCapUsd.or(""))"
            value = "$\(ticket.priceUsd.or(""))"
            percentChange1h = "\(ticket.percentChange1h.or(""))%"
            percentChange24h = "\(ticket.percentChange24h.or(""))%"
            percentChange7d = "\(ticket.percentChange7d.or(""))%"
            volumn = "Volume 24h: $\(ticket.volume24hUsd.or(""))"
            self.ticket = ticket
        }
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
            indexLabel.text = "\(data.index)"
            iconImageView.setImage(urlString: data.iconPath)
            titleLabel.text = data.title
            capLabel.text = data.cap
            valueLabel.text = data.value
            increaseLabel.text = data.percentChange1h
            volumeLabel.text = data.volumn
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
