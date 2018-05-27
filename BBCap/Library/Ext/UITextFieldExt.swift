//
//  UITextFieldExt.swift
//  BBCap
//
//  Created by Lam Le V. on 5/11/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

extension UITextField {

    /// - TextField placeholderColor
    @IBInspectable var placeholderColor: UIColor {
        set {
            attributedPlaceholder = NSAttributedString(string: placeholder.unwrapped(or: ""), attributes: [.foregroundColor: newValue])
        }
        get {
            return (attributedPlaceholder?.attributes[.foregroundColor] as? UIColor).unwrapped(or: .black)
        }
    }

    public func addPaddingRightIcon(_ image: UIImage, padding: CGFloat) {
        let imageView = UIImageView(image: image)
        imageView.contentMode = .center
        self.rightView = imageView
        self.rightView?.frame.size = CGSize(width: image.size.width + padding, height: image.size.height)
        rightViewMode = .always
    }
}
