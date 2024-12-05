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
    lazy var loginViewModel = LoginViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setui()
        setTextFieldDelegate()
        hidekeyboard()
        setupViewModelBindings()
        
        usernameTextField.text = "Mayur321@gmail.com"
        passwordTextField.text = "Mayur@321"
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
                    print(EventConstants.Loading)
                case .stopLoading:
                    print(EventConstants.StoppedLoading)
                case .dataLoaded:
                    self.showAlert(title: AlertConstants.Success, message: "Logged in successfully!") {
                        self.navigateToScreen(storyboardName: SbConstants.HomeScreen, viewControllerID: SbConstants.HomeScreen)
                    }
                
                case .error(let error):
                    if let error = error as? DataError {
                        self.showAlert(title: EventConstants.Error, message: error.localizedError)

                    }
                 
                }
            }
        }
    
    private func showAlert(title: String, message: String, completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            completion?()
        }))
        
        present(alertController, animated: true)
    }

    @IBAction func Forgetpasswordbtntapped(_ sender: Any) {
        navigateToScreen(storyboardName: SbConstants.Main, viewControllerID: SbConstants.ForgetPasswordViewController)
    }
    @IBAction func Registerbtntapped(_ sender: Any) {
        navigateToScreen(storyboardName: SbConstants.Main, viewControllerID: SbConstants.RegisterViewController)
    }
    @IBAction func loginbtntapped(_ sender: Any) {
        guard let email = usernameTextField.text, !email.isEmpty,
                     let password = passwordTextField.text, !password.isEmpty else {
            showAlert(title: AlertConstants.ValidationError, message: "Please enter both email and password.")
                   return
               }
               
               let loginModel = LoginModel(email: email, password: password)
               
               loginViewModel.getRequest(logs: loginModel)
    }
}

