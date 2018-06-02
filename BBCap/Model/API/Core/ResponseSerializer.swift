//
//  ResponseSerializer.swift
//  BBCap
//
//  Created by iOSTeam on 2/21/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Alamofire
import ObjectMapper
import SwiftUtils

extension Request {
    static func responseJSONSerializer(log: Bool = true,
                                       response: HTTPURLResponse?,
                                       data: Data?,
                                       error: Error?) -> Result<Any> {
        if let error = error {
            return .failure(error)
        }

        guard let response = response else {
            return .failure(Api.Error.noResponse)
        }

        let statusCode = response.statusCode

        if 204...205 ~= statusCode { // empty data status code
            return .success([:])
        }

        guard 200...299 ~= statusCode else {

            var err: NSError!
            if let json = data?.toJSON() as? JSObject, let message = json["message"] as? String {
                err = NSError(domain: Api.Path.baseURL.host, code: statusCode, message: message)
            } else if let status = HTTPStatus(code: statusCode) {
                err = NSError(domain: Api.Path.baseURL.host, status: status)
            } else {
                err = NSError(domain: Api.Path.baseURL.host,
                              code: statusCode,
                              message: "Unknown HTTP status code received (\(statusCode)).")
            }
            #if DEBUG
                print("------------------------")
                print("Request: \(String(describing: response.url))")
                print("Error: \(err.code) - \(err.localizedDescription)")
            #endif
            return .failure(err)
        }

        guard let data = data, let json = data.toJSON() else {
            return Result.failure(Api.Error.json)
        }

        return .success(json)
    }
}

extension DataRequest {
    static func responseSerializer() -> DataResponseSerializer<Any> {
        return DataResponseSerializer { _, response, data, error in
            return Request.responseJSONSerializer(log: true,
                                                  response: response,
                                                  data: data,
                                                  error: error)
        }
    }

    @discardableResult
    func responseJSON(queue: DispatchQueue = .global(qos: .background),
                      completion: @escaping (DataResponse<Any>) -> Void) -> Self {
        return response(queue: queue,
                        responseSerializer: DataRequest.responseSerializer(),
                        completionHandler: completion)
    }
}
