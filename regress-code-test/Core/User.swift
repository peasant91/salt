//
//  User.swift
//  regress-code-test
//
//  Created by Kevin Raymond on 08/11/22.
//

import Foundation
class User {
    public static let shared = User()
}

extension User {
    
    func saveUserCredential(model: LoginModel) {
        PreferenceManager.shared.save(Constants.Preferences.accessToken, model.token)
    }
    
    func saveUserProfile(_ email: String) {
        PreferenceManager.shared.save(Constants.Preferences.email, email)
    }
    func token() -> String? {
        return PreferenceManager.shared.load(Constants.Preferences.accessToken)
    }
    
    func email() -> String? {
        return PreferenceManager.shared.load(Constants.Preferences.email)
    }
    
    func logout(apiLogout: Bool = true) {
        PreferenceManager.shared.deleteAll()
    }
}
