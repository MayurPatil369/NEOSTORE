//
//  Navigation.swift
//  neostore
//
//  Created by Neosoft on 28/10/24.
//
import UIKit

extension UIViewController {

    func navigateToScreen(storyboardName: String, viewControllerID: String) {
        
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        
        let viewController = storyboard.instantiateViewController(withIdentifier: viewControllerID)
        
        if let navigationController = self.navigationController {
            navigationController.pushViewController(viewController, animated: true)
        } else {
            print("Error: No navigation controller found.")
        }
    }
    
    func goToPreviousScreen() {
         if let navigationController = self.navigationController {
             navigationController.popViewController(animated: true)
         } else {
             print("Error: No navigation controller found.")
         }
     }
    
    
    
}


