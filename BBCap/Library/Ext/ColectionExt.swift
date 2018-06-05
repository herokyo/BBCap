//
//  ColectionExt.swift
//  BBCap
//
//  Created by MBA0105 on 5/6/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import UIKit

extension Collection {

    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }

    var isNotEmpty: Bool {
        return !isEmpty
    }
}

extension Array where Element: UIButton {

    func setSelected(isTrue: Bool) {
        self.forEach(where: { (button) -> Bool in
            button.isSelected != isTrue
        }, body: { (button) in
            button.isSelected = isTrue
        })
    }
}
