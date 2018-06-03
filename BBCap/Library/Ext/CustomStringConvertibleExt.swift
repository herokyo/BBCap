//
//  CustomStringConvertibleExt.swift
//  BBCap
//
//  Created by MBA0105 on 5/6/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

extension CustomStringConvertible where Self: AnyObject {

    var description: String {
        var description: String = "\n***** \(type(of: self)) *****\(Unmanaged<Self>.passUnretained(self).toOpaque())\n"
        let selfMirror = Mirror(reflecting: self)
        for child in selfMirror.children {
            if let propertyName = child.label {
                description += "\(propertyName): \(child.value)\n"
            }
        }
        return description
    }
}

extension Ticket: CustomStringConvertible {}
