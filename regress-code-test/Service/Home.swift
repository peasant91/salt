//
//  Home.swift
//  regress-code-test
//
//  Created by Kevin Raymond on 08/11/22.
//

import Foundation
import Alamofire
import RxSwift

class HomeAPI: APIRequest {
    func fetchListUser(query: Parameters) -> Observable<ListUserModel> {
        let request = get(key: APIConstants.home.key, query)
        return Alamofire.request(request).rx.response()
    }
}
