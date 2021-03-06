//
//  CurrencyVolumeView.swift
//  BBCap
//
//  Created by Lam Le V. on 5/6/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
import AwesomeEnum
import SwifterSwift

final class CurrencyVolumeView: BBView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!

    var viewModel = CurrencyVolumeViewModel() {
        didSet {
            updateView()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
    }

    func updateView() {
        titleLabel.text = viewModel.title
        guard let volumeType = viewModel.volumeType, let priceType = viewModel.priceType else { return }
        switch volumeType {
        case .cap, .volume24h:
            currencyLabel.setText(type: priceType, postfixText: viewModel.currency)
            currencyLabel.textAlignment = .right
        case .totalSupply, .availableSupply:
            currencyLabel.text = viewModel.currency
        }
    }
}
