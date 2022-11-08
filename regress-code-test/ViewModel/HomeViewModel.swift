//
//  HomeViewModel.swift
//  regress-code-test
//
//  Created by Kevin Raymond on 08/11/22.
//

import Foundation

class HomeViewModel: NSObject {
    
    var page: Int = 1
    var handler: HomeAPI!
    var data: ListUserModel? = nil
    
    var listUser: [UserModel]? = nil {
        didSet {
            self.bindDataView?(self.listUser)
        }
    }
    
    var bindDataView: ((_ data: [UserModel]?) -> ())?
    var showError: ((_ error: ErrorModel) -> ())?
    
    override init() {
        super.init()
        self.handler = HomeAPI()
        self.refreshPage()
    }
    
    func doFetch() {
        _ = self.handler.fetchListUser(query: [
            "page": String(page)
        ]).subscribe(onNext: { response in
            self.data = response
            if self.listUser == nil {
                self.listUser = []
            }
            
            self.listUser?.append(contentsOf: response.data)
        }, onError: { _error in
            if let error = _error as? ErrorModel {
                self.showError?(error)
            }
        }, onCompleted: nil, onDisposed: nil)
    }
    
    func fetchNextPage() {
        guard let _data = self.data else {
            self.bindDataView?(self.listUser)
            return
        }
        if self.page <= _data.totalPages {
            self.page += 1
            self.doFetch()
        } else {
            self.bindDataView?(self.listUser)
        }
    }
    
    func refreshPage() {
        self.listUser = nil
        self.page = 1
        self.doFetch()
    }
}
