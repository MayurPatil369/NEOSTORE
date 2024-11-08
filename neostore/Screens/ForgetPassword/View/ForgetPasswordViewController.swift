//
//  ForgetPasswordViewController.swift
//  neostore
//
//  Created by Neosoft on 28/10/24.
//

import UIKit

class ForgetPasswordViewController: UIViewController {
    @IBOutlet weak var UsernameTextField: UITextField!
    
    @IBOutlet weak var btn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setui()
        setTextFieldDelegate()
    }
    
    func setui(){
        UsernameTextField.setIcon(UIImage(named: Constants.Usernameicon) ?? UIImage(), padding: 8)
        
        UsernameTextField.setPlaceholder(color: .white)
        
        UsernameTextField.setBorder(color: .white, width: 1.5)
    }
    
    @IBAction func submitbtntapped(_ sender: Any) {
        goToPreviousScreen()
    }
    
    
}
