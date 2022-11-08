//
//  HomeViewController.swift
//  regress-code-test
//
//  Created by Kevin Raymond on 08/11/22.
//

import UIKit
import SVPullToRefresh

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            self.tableView.addPullToRefresh {
                self.vm.refreshPage()
            }
            
            self.tableView.addInfiniteScrolling {
                self.vm.fetchNextPage()
            }
        }
    }
    
    var vm: HomeViewModel!
    
    fileprivate lazy var dataSource: HomeDataSource = {
        let dataSource = HomeDataSource(self.tableView, {() in
            User.shared.logout()
            let controller = LoginViewController.instantiateStoryboard()
            controller.modalTransitionStyle = .crossDissolve
            controller.modalPresentationStyle = .fullScreen
            self.present(controller, animated: true)
        })
        return dataSource
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideNavBar()
        self.vm = HomeViewModel()
        
        self.vm.bindDataView = { (_ data: [UserModel]?) in
            self.tableView.pullToRefreshView.stopAnimating()
            self.tableView.infiniteScrollingView.stopAnimating()
            self.dataSource.data = data
            self.tableView.reloadData()
        }
        
        self.vm.showError = { (_ error: ErrorModel) in
            self.tableView.pullToRefreshView.stopAnimating()
            self.tableView.infiniteScrollingView.stopAnimating()
            self.showError(error)
        }
    }
}

extension UIViewController {
    func showError(_ error: ErrorModel) {
        let alert = UIAlertController(title: "ERROR", message: error.title, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        self.present(alert, animated: true)
    }
    
    func hideNavBar() {
        self.navigationController?.navigationBar.isHidden = true
    }
}
