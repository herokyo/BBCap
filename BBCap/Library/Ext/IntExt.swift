//
//  IntExt.swift
//  BBCap
//
//  Created by Hai Phung N.T. on 6/3/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

extension Int {

    enum Notation {
        case billion
        case million
        case thousand
        case none

        init(value: Int) {
            switch value {
            case _ where value >= Notation.billion.value:
                self = .billion
            case _ where value >= Notation.million.value:
                self = .million
            case _ where value >= Notation.thousand.value:
                self = .thousand
            default:
                self = .none
            }
        }

        var value: Int {
            switch self {
            case .billion: return 1_000_000_000
            case .million: return 1_000_000
            case .thousand: return 1_000
            case .none: return 1
            }
        }

        var unit: String {
            switch self {
            case .billion: return "B"
            case .million: return "M"
            case .thousand: return "K"
            case .none: return ""
            }
        }
    }

    var convertedResult: String {
        let notation = Notation(value: self)
        switch self {
        case _ where self <= 999:
            return "\(self / notation.value)\(notation.unit)"

        case _ where self <= 9_999:
            let hundreds = self % 1_000
            switch hundreds {
            case _ where hundreds < 10:
                return "\((self - hundreds) / 1_000),00\(hundreds)"
            case _ where hundreds < 100:
                return "\((self - hundreds) / 1_000),0\(hundreds)"
            default:
                return "\((self - hundreds) / 1_000),\(hundreds)"
            }

        case _ where self <= 99_999:
            // Round to 1 decimal
            let number = Double(Int(Double(self) / Double(notation.value) * 10)).rounded() / 10

            // Check if decimal == .0 then remove it
            if Int(number * 100) % 100 == 0 {
                return "\(Int(number))\(notation.unit)"
            }
            return "\(number)\(notation.unit)"

        default:
            var number = Double(self) / Double(notation.value)
            number = (number * 10).round / 10
            return "\(number)\(notation.unit)"
        }
    }
}
