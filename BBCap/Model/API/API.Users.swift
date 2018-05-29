//
//  API.Users.swift
//  BBCap
//
//  Created by Lam Le V. on 5/29/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

protocol UsersProtocol {
    associatedtype Element
    var uuid: String { get }
    var deviceType: String { get }
    var params: [JSObject] { get }
    func token(completion: @escaping Completion<Element>)
}

extension Api {
    struct Users {}
}

// Handle with User protocol
extension Api.Users {}
