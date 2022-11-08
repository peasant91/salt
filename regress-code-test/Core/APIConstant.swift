//
//  APIConstant.swift
//  regress-code-test
//
//  Created by Kevin Raymond on 07/11/22.
//

import Foundation

struct APIClass {
    var version: String
    var path: String
    
    init(_ version: String, _ path: String) {
        self.version = version
        self.path = path
    }
    
    func getPath() -> String {
        return Constants.baseURL + self.path
    }
}

enum APIConstants {
    case login
    case home
    
    var key: APIClass {
        switch self {
        case .login:
            return APIClass("v1", "login")
        case .home:
            return APIClass("v1", "users")
        }
    }
}
