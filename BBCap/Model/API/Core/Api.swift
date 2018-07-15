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
        static let baseURL = "http://45.32.126.226"
        #elseif STG
        static let baseURL = "http://45.32.126.226"
        #else
        static let baseURL = "http://45.32.126.226"
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

    struct Exchanges {
        static let path = baseURL / v1 / "exchanges"
    }
}

extension Api.CoinmarketCap {

    struct Currencies {
        static let path = Api.CoinmarketCap.path / "currencies"
    }

    struct Global {
        static let path = Api.CoinmarketCap.path / "v1/global"
    }

    struct Tickets {
        static let path = Api.CoinmarketCap.path / "v1/ticker/?start=0&limit=0"
    }
}

extension Api.CoinmarketCap.Currencies {

    struct Bitcoin {

        var startDate: TimeInterval
        var endDate: TimeInterval
        var currency: String

        var path: String {
            return Api.CoinmarketCap.Currencies.path / currency / startDate.int64 / endDate.int64
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

extension URLStringConvertible where Self: SignedInteger {
    var urlString: String { return String(describing: self) }
}

extension Int64: URLStringConvertible { }

private func / (lhs: URLStringConvertible, rhs: URLStringConvertible) -> String {
    return lhs.urlString + "/" + rhs.urlString
}

extension String: URLStringConvertible {
    var urlString: String { return self }
}

extension CustomStringConvertible where Self: URLStringConvertible {
    var urlString: String { return description }
}
