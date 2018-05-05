//
//  Ratio.swift
//  BBCap
//
//  Created by Lam Le V. on 5/5/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import SwifterSwift
import SwiftUtils

struct Ratio {
    static let horizontal = SwifterSwift.screenWidth / DeviceType.iPhone6.size.width
    static let vertical = SwifterSwift.screenHeight / DeviceType.iPhone6.size.height
}
