//
//  API.Coinmarket.swift
//  BBCap
//
//  Created by Lam Le V. on 6/1/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import ObjectMapper

extension Api.CoinmarketCap {

    static func getTickets(completion: @escaping Completion<[Ticket]>) {
        let path = Api.CoinmarketCap.Tickets.path
        api.request(method: .get, urlString: path) { result in
            switch result {
            case .success(let value):
                guard let json = value as? JSArray else {
                    completion(.failure(Api.Error.json))
                    return
                }
                let tickets = Mapper<Ticket>().mapArray(JSONArray: json)
                completion(.success(tickets))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    static func getGlobal(completion: @escaping Completion<GlobalInfo>) {
        let path = Api.CoinmarketCap.Global.path
        api.request(method: .get, urlString: path) { result in
            switch result {
            case .success(let value):
                guard let json = value as? JSObject, let currency = Mapper<GlobalInfo>().map(JSON: json) else {
                    completion(.failure(Api.Error.json))
                    return
                }
                completion(.success(currency))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    static func getCurrencyBitcoin(type: DetailViewModel.TimeType, completion: @escaping Completion<Currency>) {
        let path = Api.CoinmarketCap.Currencies.Bitcoin(startDate: type.pastTimeInterval, endDate: type.currentTimeInterval).path
        api.request(method: .get, urlString: path) { result in
            switch result {
            case .success(let value):
                guard let json = value as? JSObject, let currency = Mapper<Currency>().map(JSON: json) else {
                    completion(.failure(Api.Error.json))
                    return
                }
                completion(.success(currency))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
