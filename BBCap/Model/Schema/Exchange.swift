//
//  Exchange.swift
//  BBCap
//
//  Created by Lam Le V. on 7/15/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import ObjectMapper

final class Exchange: Mappable {

    var id = ""
    var name = ""
    var position: Int?
    var iconPath = ""
    var website = ""
    var chat = ""
    var twitter = ""
    var symbol = ""

    init?(map: Map) {
        guard let id = map.JSON["id"] as? String, id.isNotEmpty else { return nil }
    }

    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        position <- map["position"]
        iconPath <- map["icon"]
        website <- map["website"]
        twitter <- map["twitter"]
        chat <- map["chat"]
        symbol <- map["symbol"]
    }
}
