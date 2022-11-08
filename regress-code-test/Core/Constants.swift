//
//  Constants.swift
//  regress-code-test
//
//  Created by Kevin Raymond on 07/11/22.
//

import Foundation

struct Constants {
    static let serverDateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS'Z'"
    
    struct Preferences {
        static let accessToken = "accessToken"
        static let name = "name"
        static let email = "email"
    }

    
    #if ENV_DEBUG
    static let baseURL = "https://reqres.in/api/"
    #else
    static let baseURL = "https://reqres.in/api/"
    #endif
}
