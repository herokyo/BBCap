//
//  CalculationProtocol.swift
//  BBCap
//
//  Created by Lam Le V. on 6/6/18.
//  Copyright © 2018 Asian Tech Co., Ltd. All rights reserved.
//

import Foundation

extension String {

    enum Invalid: Error {
        case numerator
        case denominator
        case divideForZero
    }

    func plus(_ value: Double) throws -> String {
        guard let double = double() else {
            throw Invalid.numerator
        }
        let value = double + value
        guard value.isInt else { return value.description }
        return value.int64.description
    }

    func plus(_ value: String) throws -> String {
        guard let value = value.double() else {
            throw Invalid.denominator
        }
        return try plus(value)
    }

    func minus(_ value: Double) throws -> String {
        return try plus(-value)
    }

    func minus(_ value: String) throws -> String {
        guard let value = value.double() else {
            throw Invalid.denominator
        }
        return try minus(value)
    }

    func multiplier(_ value: Double) throws -> String {
        guard let double = double() else {
            throw Invalid.numerator
        }
        let value = double * value
        guard value.isInt else { return value.description }
        return value.int64.description
    }

    func multiplier(_ value: String) throws -> String {
        guard let value = value.double() else {
            throw Invalid.denominator
        }
        return try multiplier(value)
    }

    func divide(_ value: Double) throws -> String {
        guard let double = double() else {
            throw Invalid.numerator
        }
        if value == 0 {
            throw Invalid.divideForZero
        }
        let value = double / value
        guard value.isInt else { return value.description }
        return value.int64.description
    }

    func divide(_ string: String) throws -> String {
        guard let value = string.double() else {
            throw Invalid.denominator
        }
        return try divide(value)
    }
}
