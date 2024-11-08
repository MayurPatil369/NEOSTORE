//
//  Validations.swift
//  neostore
//
//  Created by Neosoft on 30/10/24.
//

import Foundation
import UIKit


enum TextFieldType {
    case firstName, lastName, email, password, confirmPassword, mobileNumber
}

extension UITextField {
    func validate(for type: TextFieldType, passwordToMatch: String? = nil) -> Bool {
        guard let text = self.text, !text.isEmpty else { return false }
        
        switch type {
        case .firstName, .lastName:
            return text.count > 3 && text.range(of: "^[a-zA-Z]+$", options: .regularExpression) != nil
        case .email:
            return text.range(of: "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}$", options: .regularExpression) != nil
        case .password:
            return text.range(of: "(?=.*[0-9])(?=.*[!@#$&*]).{8,}", options: .regularExpression) != nil
        case .confirmPassword:
            return text == passwordToMatch
        case .mobileNumber:
            return text.range(of: "^[0-9]{10}$", options: .regularExpression) != nil
        }
    }
}





