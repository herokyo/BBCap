//
//  UILabelExt.swift
//  BBCap
//
//  Created by Lam Le V. on 5/5/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit
import AwesomeEnum
import Font_Awesome_Swift
import SwifterSwift

enum PriceType: String {
    case usd = "USD"
    case btc = "BTC"
    case eth = "ETH"
}

extension UILabel {

    @IBInspectable var pointSizeRatio: CGFloat {
        get {
            return font.pointSize
        }
        set {
            font = font.withSize(newValue * Ratio.horizontal)
        }
    }

    func setText(type: PriceType, postfixText: String?) {
        guard let postfixText = postfixText, postfixText.isNotEmpty else {
            text = nil
            return
        }
        switch type {
        case .eth:
            let firstAttributedText = Awesome.brand.ethereum.asAttributedText(fontSize: font.pointSize, color: textColor, backgroundColor: backgroundColor.or(.clear))
            attributedText = firstAttributedText + postfixText
        case .btc:
            setFAText(prefixText: "", icon: FAType.FABitcoin, postfixText: postfixText, size: font.pointSize)
        case .usd:
            setFAText(prefixText: "", icon: FAType.FADollar, postfixText: postfixText, size: font.pointSize)
        }
    }
}
