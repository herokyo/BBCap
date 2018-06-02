//
//  RawRepresentableExt.swift
//  BBCap
//
//  Created by MBA0105 on 5/6/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

extension RawRepresentable where Self.RawValue == Int {

    static var caseCount: Int {
        var count = 0
        while let _ = Self(rawValue: count) {
            count += 1
        }
        return count
    }
}

func enumCount<T: Hashable>(_: T.Type) -> Int {
    var i = 1
    while (withUnsafePointer(to: &i, {
        return $0.withMemoryRebound(to: T.self, capacity: 1, { return $0.pointee })
    }).hashValue != 0) {
        i += 1
    }
    return i
}
