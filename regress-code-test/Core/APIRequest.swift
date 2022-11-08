//
//  APIRequest.swift
//  regress-code-test
//
//  Created by Kevin Raymond on 07/11/22.
//

import Foundation
import Alamofire

protocol APIRequest {
}

extension APIRequest {
    func get(key: APIClass, _ query: Parameters?) -> URLRequest {
        var request: URLRequest!
        var url = URLComponents(string: key.getPath())!
        if query != nil {
            var queryItems = [URLQueryItem]()
            for data in query! {
                queryItems.append(URLQueryItem(name: data.key, value: data.value as? String))
            }
            url.queryItems = queryItems
        }
        
        request = URLRequest(url: url.url!)
        request.httpMethod = "GET"
        request.timeoutInterval = 30
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        return request
    }
    
    func post(key: APIClass, _ query: Parameters? ) -> URLRequest {

        var request: URLRequest!
        var url = URLComponents(string: key.getPath())!
        request = URLRequest(url: url.url!)
        request.httpBody = query?.percentEscaped().data(using: .utf8)
        request.httpMethod = "POST"
        request.timeoutInterval = 30
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        
        return request
    }
    
}
