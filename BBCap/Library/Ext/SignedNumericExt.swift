//
//  SignedNumericExt.swift
//  BBCap
//
//  Created by Lam Le V. on 5/6/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

extension SignedNumeric {

    func format(style: NumberFormatter.Style, fraction: Int = 0) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = style
        formatter.locale = Locale.current
        formatter.minimumFractionDigits = fraction
        formatter.maximumFractionDigits = fraction
        guard let number = self as? NSNumber else { return "" }
        return formatter.string(from: number) ?? ""
    }

    func formatCurrency(fraction: Int = 0) -> String {
        return format(style: .currency, fraction: fraction)
    }

    func formatDecimal(fraction: Int = 0) -> String {
        return format(style: .decimal, fraction: fraction)
    }
}
