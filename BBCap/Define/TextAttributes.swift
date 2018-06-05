//
//  TextAttributes.swift
//  BBCap
//
//  Created by Hai Phung N.T. on 6/4/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

typealias TextAttributes = App.TextAttributes

extension App {

    struct TextAttributes {

        static let normal: [NSAttributedStringKey: Any] = {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            let attributes: [NSAttributedStringKey: Any] = [.font: UIFont.systemFont(ofSize: 15),
                                                            .foregroundColor: UIColor.white,
                                                            .paragraphStyle: paragraphStyle]
            return attributes
        }()

        static let green: [NSAttributedStringKey: Any] = {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            let attributes: [NSAttributedStringKey: Any] = [.font: UIFont.systemFont(ofSize: 14),
                                                            .foregroundColor: UIColor.green,
                                                            .paragraphStyle: paragraphStyle]
            return attributes
        }()
    }
}
