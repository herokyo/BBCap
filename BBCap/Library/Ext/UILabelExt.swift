//
//  UILabelExt.swift
//  BBCap
//
//  Created by Lam Le V. on 5/5/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

extension UILabel {

    @IBInspectable var pointSizeRatio: CGFloat {
        get {
            return font.pointSize
        }
        set {
            font = font.withSize(newValue * Ratio.horizontal)
        }
    }
}
