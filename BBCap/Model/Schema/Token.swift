//
//  Token.swift
//  BBCap
//
//  Created by Lam Le V. on 5/29/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import ObjectMapper

final class Token: Mappable {

    var apiToken = ""

    init?(map: Map) {
    }

    func mapping(map: Map) {
        apiToken <- map["api_token"]
    }
}
