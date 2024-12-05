//
//  ResetPasswordViewModel.swift
//  neostore
//
//  Created by Neosoft on 26/11/24.
//

import Foundation
import UIKit


extension ResetPasswordViewController{
    
    func resetRequest(logs: ResetRequest) {
        
        APIManager.shared.manager(modelType: ResetResponse.self, type: APIEndpoints.resetPass, requestModel: logs , method: .post){
            result in
            switch result {
            case .success(_):
                DispatchQueue.main.async{
                    self.navigateToScreen(storyboardName: "Main", viewControllerID: "LoginViewController")
                }
            case .failure(let error):
                print(error.localizedError)
            }
        }
        
    }
}
