//
//  CurrencyVolumeView.swift
//  BBCap
//
//  Created by Lam Le V. on 5/6/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

class CurrencyVolumeView: BBView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!

    var viewModel = CurrencyVolumeViewModel() {
        didSet {
            titleLabel.text = viewModel.title
            currencyLabel.text = viewModel.currency
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
    }
}
