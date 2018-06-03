//
//  Color.swift
//  BBCap
//
//  Created by iOSTeam on 2/21/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

/**
 This file defines all colors which are used in this application.
 Please navigate by the control as prefix.
 */

import UIKit

extension App {
    struct Color {
        static let navigationBar = UIColor.black
        static let tableHeaderView = UIColor.gray
        static let tableFooterView = UIColor.red
        static let tableCellTextLabel = UIColor.yellow

        // BB color
        static let bbGreenColor: UIColor! = UIColor(red: 0, green: 224, blue: 151)
        static let bbBlackColor: UIColor! = UIColor(red: 24, green: 19, blue: 32)
        static let bbRedColor: UIColor! = UIColor(red: 243, green: 0, blue: 113)
        static let bbLightGreenColor: UIColor! = UIColor(red: 0, green: 215, blue: 145)

        static func button(state: UIControlState) -> UIColor {
            switch state {
            case UIControlState.normal: return .blue
            default: return .gray
            }
        }
    }
}
