//
//  Api.Exchanges.swift
//  BBCap
//
//  Created by Lam Le V. on 7/15/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import ObjectMapper

extension Api {

    struct Exchanges {

        static func getList(completion: @escaping Completion<[Exchange]>) {
            let path = Api.Path.Exchanges.path
            api.request(method: .get, urlString: path) { result in
                switch result {
                case .success(let value):
                    guard let json = value as? JSObject,
                        let exchanges = Mapper<Exchange>().mapArray(JSONObject: json["data"]) else {
                            completion(.failure(Api.Error.json))
                            return
                    }
                    completion(.success(exchanges))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}
