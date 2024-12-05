//
//  orderViewModel.swift
//  neostore
//
//  Created by Neosoft on 27/11/24.
//

import Foundation
import UIKit


extension AddressListViewController {
    
    func orderRequest(logs: OrderRequest) {
        
        APIManager.shared.manager(modelType: OrderModel.self, type: APIEndpoints.order, requestModel: logs , method: .post){
            result in
            switch result {
            case .success(let jsonData):
                print(jsonData)
//                self.showAlert1(message: "Order Successfully Placed")
                DispatchQueue.main.async{
                    self.navigateToScreen(storyboardName: "HomeScreen", viewControllerID: "HomeScreen")
                }
            case .failure(_):
                print("Error:")
            }
        }
        
    }
}
