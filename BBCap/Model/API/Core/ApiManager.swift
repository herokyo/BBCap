//
//  ApiManager.swift
//  BBCap
//
//  Created by iOSTeam on 2/21/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import Alamofire

typealias JSObject = [String: Any]
typealias JSArray = [JSObject]

enum ApiResult {
    case success
    case failure(Error)
}

typealias ApiCompletion = (ApiResult) -> Void
typealias Completion<Value> = (Result<Value>) -> Void

let api = ApiManager()

final class ApiManager {

    var defaultHTTPHeaders: [String: String] {
        var headers: [String: String] = [:]
        headers["clientID"] = App.Key.clientID
        headers["Content-Type"] = "application/json"
        return headers
    }
}
