//
//  ErrorModel.swift
//  regress-code-test
//
//  Created by Kevin Raymond on 08/11/22.
//

import Foundation

class BaseErrorModel: Codable {
    var error: String?
}

class ErrorModel: Error, Codable {
    var code: Int
    var title: String
//    var errors: [ErrorData] = []
    
    init(_ code: Int, title: String, message: String) {
        self.code = code
        self.title = title
//        let data = ErrorData(title, message)
//        self.errors.append(data)
    }
    
//    func getFirstTitle() -> String {
//        return self.errors.first?.title ?? ""
//    }
//    
//    func getFirstDesc() -> String {
//        return self.errors.first?.message ?? ""
//    }
}

