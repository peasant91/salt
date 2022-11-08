//
//  LoginViewController.swift
//  regress-code-test
//
//  Created by Kevin Raymond on 08/11/22.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var passwordTextField: BaseTextField! {
        didSet {
            self.passwordTextField.validationTypes = [.password, .empty]
        }
    }
    @IBOutlet weak var emailTextField: BaseTextField! {
        didSet {
            self.emailTextField.validationTypes = [.email, .empty]
        }
    }
    
    @IBOutlet weak var loginButton: BaseButton!
    
    private var vm: LoginViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.vm = LoginViewModel()
        
        self.vm.loginSuccess = {
            self.loginButton.stopAnimation(animationStyle: .expand, revertAfterDelay: 1) {
                let controller = HomeViewController.instantiateStoryboard() as! HomeViewController
                controller.modalTransitionStyle = .crossDissolve
                controller.modalPresentationStyle = .fullScreen
                self.present(controller, animated: false)
            }
        }
        
        self.vm.loginFailure = { (_error: ErrorModel) in
            self.loginButton.stopAnimation(animationStyle: .shake, revertAfterDelay: 2) {
                let alert = UIAlertController(title: "Error", message: _error.title, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                self.present(alert, animated: true)
            }
        }
    }
    
    @IBAction func loginTouchUpInside(_ sender: Any) {
        var isValid: [Bool] = []
        isValid.append(self.emailTextField.hasError)
        isValid.append(self.passwordTextField.hasError)
        if isValid.contains(true) {
             return
        }
        
        self.loginButton.startAnimation()
        self.vm.doLogin(emailTextField.text ?? "", passwordTextField.text ?? "")
    }
}
