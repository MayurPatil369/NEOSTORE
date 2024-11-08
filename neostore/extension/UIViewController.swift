//
//  UIViewController.swift
//  neostore
//
//  Created by Neosoft on 30/10/24.
//

import Foundation
import UIKit
extension UIViewController:UITextFieldDelegate{
    func hidekeyboard(){
        let gesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(gesture)
    }
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func setTextFieldDelegate(){
        for subview in view.subviews{
            if let textField = subview as? UITextField{
                textField.delegate = self
            }
        }
    }
}
