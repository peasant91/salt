//
//  HTTPStatusCode.swift
//  regress-code-test
//
//  Created by Kevin Raymond on 07/11/22.
//

import Foundation

enum HTTPStatusCode: Int {
    case badRequest = 400
    case notRegistered = 404
    case notConnected = 101
    case unauthorized = 401
    case badValidation = 422
    case internalServerError = 500
    case parsingError = 501
    case noInternet = 1009
    case timeout = 1001
}
