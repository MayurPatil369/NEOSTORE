//
//  AlertFieldExtension.swift
//  neostore
//
//  Created by Neosoft on 19/11/24.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlert1(title: String?, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: AlertConstants.OK, style: .default, handler: nil))
        
        present(alertController, animated: true)
    }
}

