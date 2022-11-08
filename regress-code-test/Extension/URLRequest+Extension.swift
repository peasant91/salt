//
//  URLRequest+Extension.swift
//  regress-code-test
//
//  Created by Kevin Raymond on 08/11/22.
//

import Foundation

extension URLRequest {

    func asJson() -> URLRequest {
        var request = self
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
    
    func asFormURLEncoded() -> URLRequest {
        var request = self
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        return request
    }
    
//    func withToken() -> URLRequest {
//        var request = self
//        if User.shared.isLogin() {
//            request.addValue("Bearer \(User.shared.token() ?? "")", forHTTPHeaderField: "Authorization")
//        }
//        return request
//    }
}

