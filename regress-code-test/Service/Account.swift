//
//  Account.swift
//  regress-code-test
//
//  Created by Kevin Raymond on 08/11/22.
//

import Foundation
import Alamofire
import RxSwift

class LoginAPI: APIRequest {
    func login(query: Parameters) -> Observable<LoginModel> {
        let request = post(key: APIConstants.login.key, query)
        return Alamofire.request(request).rx.response()
    }
}
