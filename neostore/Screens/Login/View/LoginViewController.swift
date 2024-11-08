//
//  LoginViewController.swift
//  neostore
//
//  Created by Neosoft on 28/10/24.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginbtn: UIButton!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var Forgetpasswordbtn: UIButton!
    
    @IBOutlet weak var Registerbtn: UIButton!
    var resp : LoginResponse?
    var loginViewModel = LoginViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setui()
        setTextFieldDelegate()
        hidekeyboard()
        setupViewModelBindings()
    }
    
    func setui(){
        usernameTextField.setIcon(UIImage(named: Constants.Usernameicon) ?? UIImage(), padding: 8)
        passwordTextField.setIcon(UIImage(named: Constants.PasswordIcon) ?? UIImage(), padding: 8)
        
        usernameTextField.setPlaceholder(color: .white)
        passwordTextField.setPlaceholder(color: .white)
        
        usernameTextField.setBorder(color: .white, width: 1.5)
        passwordTextField.setBorder(color: .white, width: 1.5)
    }
    
    private func setupViewModelBindings() {
            loginViewModel.eventHandler = { [weak self] event in
                guard let self = self else { return }
                switch event {
                case .loading:
                    print("Loading...")
                case .stopLoading:
                    print("Stopped loading.")
                case .dataLoaded:
                    
                    self.showAlert(title: "Success", message: "Logged in successfully!")
                case .error(let error):
                    self.showAlert(title: "Error", message: error?.localizedDescription ?? "Login failed. Please try again.")
                }
            }
        }
    
    private func showAlert(title: String, message: String) {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            present(alertController, animated: true)
        }
    
    @IBAction func Forgetpasswordbtntapped(_ sender: Any) {
        navigateToScreen(storyboardName: "ForgetPasswordStoryboard", viewControllerID: "ForgetPasswordViewController")
    }
    @IBAction func Registerbtntapped(_ sender: Any) {
        navigateToScreen(storyboardName: "Register", viewControllerID: "RegisterViewController")
    }
    @IBAction func loginbtntapped(_ sender: Any) {
        navigateToScreen(storyboardName: "HomeScreen", viewControllerID: "HomeScreen")
//        guard let email = usernameTextField.text, !email.isEmpty,
//                     let password = passwordTextField.text, !password.isEmpty else {
//                   showAlert(title: "Validation Error", message: "Please enter both email and password.")
//                   return
//               }
//               
//               let loginModel = LoginModel(email: email, password: password)
//               
//               loginViewModel.getRequest(logs: loginModel)
    }
}

