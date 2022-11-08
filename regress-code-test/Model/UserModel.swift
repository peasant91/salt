//
//  UserModel.swift
//  regress-code-test
//
//  Created by Kevin Raymond on 08/11/22.
//

import Foundation

class UserModel: Codable {
    var id: Int
    var email: String
    var firstName: String
    var lastName: String
    var avatar: String
}

class ListUserModel: Codable {
    var page: Int
    var perPage: Int
    var total: Int
    var totalPages: Int
    var data: [UserModel]
}
