//
//  ResetPasswordViewController.swift
//  neostore
//
//  Created by Neosoft on 26/11/24.
//

import UIKit

class ResetPasswordViewController: UIViewController {

    @IBOutlet weak var oldpass: UITextField!
    
    @IBOutlet weak var newpass: UITextField!
    
    @IBOutlet weak var confirmpass: UITextField!
    
        
    @IBOutlet weak var resetpassbtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = NavigationTitleConst.ResetPassword
        setUI()
        setTextFieldDelegate()
        hidekeyboard()
        
        // Do any additional setup after loading the view.
        
    }
    
    func setUI(){
        oldpass.setIcon(UIImage(named: Constants.PasswordIcon) ?? UIImage(), padding: 8)
        newpass.setIcon(UIImage(named: Constants.PasswordIcon) ?? UIImage(), padding: 8)
        confirmpass.setIcon(UIImage(named: Constants.PasswordIcon) ?? UIImage(), padding: 8)
        
        oldpass.setPlaceholder(color: .white)
        newpass.setPlaceholder(color: .white)
        confirmpass.setPlaceholder(color: .white)
        
        oldpass.setBorder(color: .white, width: 1.5)
        newpass.setBorder(color: .white, width: 1.5)
        confirmpass.setBorder(color: .white, width: 1.5)
    }

    @IBAction func resetbtnclicked(_ sender: Any) {
        guard let oldpassword = oldpass.text else {return}
        guard let newpassword = newpass.text else {return}
        guard let confirmpassword = confirmpass.text else {return}
        
        if newpassword == confirmpassword {
            let req = ResetRequest(old_password: oldpassword, password: newpassword, confirm_password: confirmpassword)
            self.resetRequest(logs: req)
        }
    }
}
