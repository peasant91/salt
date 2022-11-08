//
//  LoginViewModel.swift
//  regress-code-test
//
//  Created by Kevin Raymond on 08/11/22.
//

import Foundation

class LoginViewModel: NSObject {
    
    private var handler: LoginAPI!
    
    var loginSuccess: (() -> ()) = {}
    var loginFailure: ((_ error: ErrorModel) -> ())?
    
    override init() {
        super.init()
        self.handler = LoginAPI()
    }
    
    func doLogin(_ username: String, _ password: String) {
        _ = self.handler.login(query: [
            "email": username,
            "password": password
        ]).subscribe(
            onNext: { response in
                User.shared.saveUserCredential(model: response)
                User.shared.saveUserProfile(username)
                self.loginSuccess()
            }, onError: { error in
                if let _erro = error as? ErrorModel {
                    self.loginFailure?(_erro)
                }
            }
        )
    }
}
