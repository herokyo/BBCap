//
//  RequestSerializer.swift
//  BBCap
//
//  Created by iOSTeam on 2/21/18.
//  Copyright © 2016 AsianTech Co., Ltd. All rights reserved.
//

import Alamofire
import Foundation

extension ApiManager {
    @discardableResult
    func request(method: HTTPMethod = .post,
                 urlString: URLStringConvertible,
                 parameters: [String: Any]? = nil,
                 headers: [String: String]? = nil,
                 completion: Completion<Any>?) -> Request? {
        guard Network.shared.isReachable else {
            completion?(.failure(Api.Error.network))
            return nil
        }

        let encoding: ParameterEncoding
        if method == .post {
            encoding = JSONEncoding.default
        } else {
            encoding = URLEncoding.default
        }

        var newHeaders = api.defaultHTTPHeaders
        newHeaders.updateValues(headers)

        var newParams: [String: Any] = [:]
        newParams.updateValues(parameters)
        if urlString.urlString.hasPrefix(Api.Path.baseURL) && Session.shared.token.isNotEmpty {
            newParams["api_token"] = Session.shared.token
        }

        let request = Alamofire.request(urlString.urlString,
                                        method: method,
                                        parameters: newParams,
                                        encoding: encoding,
                                        headers: newHeaders
        ).responseJSON(completion: { (response) in
            completion?(response.result)
        })

        return request
    }
}
