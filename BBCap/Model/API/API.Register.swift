//
//  API.Register.swift
//  BBCap
//
//  Created by Lam Le V. on 5/29/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

protocol RegisterProtocol {
    associatedtype Element
    var uuid: String { get }
    var deviceType: Int { get }
    var params: JSObject { get }
    func token(completion: @escaping Completion<Element>)
}

extension Api {
    struct Register {}
}

extension Api.Register: RegisterProtocol {

    typealias Element = String

    var uuid: String {
        return Session.shared.uuid
    }

    var deviceType: Int {
        return 2 // android is 1, ios is 2
    }

    var params: JSObject {
        return [
            "device_uuid": uuid,
            "device_type": deviceType
        ]
    }

    func token(completion: @escaping Completion<String>) {
        let path = Api.Path.Users.path
        api.request(method: .post, urlString: path, parameters: params) { result in
            switch result {
            case .success(let value):
                guard let value = value as? JSObject, let token = value["api_token"] as? String else {
                    completion(.failure(Api.Error.json))
                    return
                }
                completion(.success(token))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
