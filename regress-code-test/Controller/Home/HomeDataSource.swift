//
//  HomeDataSource.swift
//  regress-code-test
//
//  Created by Kevin Raymond on 08/11/22.
//

import Foundation
import UIKit
import SkeletonView
import Kingfisher

class HomeDataSource: NSObject {
    var data: [UserModel]?
    var homeTableView: UITableView!
    var doLogout: (() -> Void)?
    
    init(_ tableView: UITableView, _ logout: @escaping (() -> Void)) {
        super.init()
        self.homeTableView = tableView
        self.doLogout = logout
        self.setupTableView()
    }
    
    private func setupTableView() {
        let header = HomeHeader().loadNib() as! HomeHeader
        header.doLogout = self.doLogout
        header.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 200)
        self.homeTableView.tableHeaderView = header
        self.homeTableView.delegate = self
        self.homeTableView.dataSource = self
        self.homeTableView.register(cellType: HomeTableViewCell.self)
    }
}

extension HomeDataSource: UITableViewDelegate {
}

extension HomeDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data?.count ?? 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: HomeTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.selectionStyle = .none
        guard let data = self.data else {
            cell.showAnimatedGradientSkeleton()
            return cell
        }
        
        let _data = data[indexPath.row]
        cell.hideSkeleton()
        cell.userEmail.text = _data.email
        cell.user.text = _data.firstName + " " + _data.lastName
        cell.userImageView.kf.setImage(with: URL(string: _data.avatar))
        
        return cell
    }
}
