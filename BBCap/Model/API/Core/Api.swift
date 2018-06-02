//
//  Api.swift
//  BBCap
//
//  Created by iOSTeam on 2/21/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation
import SwifterSwift

final class Api {

    struct Path {
        #if DEBUG
            static let baseURL = "https://dev-asiantech.vn"
        #elseif STG
            static let baseURL = "https://stg-asiantech.vn"
        #else
            static let baseURL = "https://pro-asiantech.vn"
        #endif

        static let v1 = "api" / "v1"
    }

    struct CoinmarketCap {
        static let path = "https://graphs2.coinmarketcap.com"
    }
}

// User app
extension Api.Path {

    struct Users {

        static let path = baseURL / v1 / "users"
    }
}

extension Api.CoinmarketCap {

    struct Currencies {
        static let path = Api.CoinmarketCap.path / "currencies"
    }
}

extension Api.CoinmarketCap.Currencies {

    struct Bitcoin {

        var startDate: TimeInterval
        var endDate: TimeInterval

        var path: String {
            return Api.CoinmarketCap.Currencies.path / "bitcoin" / startDate.int / endDate.int
        }

    }
}

protocol URLStringConvertible {
    var urlString: String { get }
}

protocol ApiPath: URLStringConvertible {
    static var path: String { get }
}

extension URL: URLStringConvertible {
    var urlString: String { return absoluteString }
}

extension Int: URLStringConvertible {
    var urlString: String { return String(describing: self) }
}

extension Double: URLStringConvertible {
    var urlString: String { return String(describing: self) }
}

private func / (lhs: URLStringConvertible, rhs: URLStringConvertible) -> String {
    return lhs.urlString + "/" + rhs.urlString
}

extension String: URLStringConvertible {
    var urlString: String { return self }
}

extension CustomStringConvertible where Self: URLStringConvertible {
    var urlString: String { return description }
}
