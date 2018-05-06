//
//  VolumeView.swift
//  BBCap
//
//  Created by Lam Le V. on 5/6/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

class VolumeView: BBView {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var currencyLabel: UILabel!

    var viewModel = VolumeViewViewModel() {
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
