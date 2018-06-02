//
//  Session.swift
//  BBCap
//
//  Created by Lam Le V. on 5/29/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

protocol SessionProtocol {
    var token: String { get set }
    var uuid: String { get }
}

final class Session {

    private init() {}

    static let shared = Session()
}

extension Session: SessionProtocol {

    var token: String {
        get {
            guard let token = ud.string(forKey: UserDefaultsKey.accessToken) else { return "" }
            return token
        }
        set {
            ud.set(newValue, forKey: UserDefaultsKey.accessToken)
        }
    }

    var uuid: String {
        if let value = ud.string(forKey: UserDefaultsKey.uuid) {
            return value
        }
        let uuid = UUID().uuidString
        ud.set(uuid, forKey: UserDefaultsKey.uuid)
        return uuid
    }
}
