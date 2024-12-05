//
//  DeleteCartViewModel.swift
//  neostore
//
//  Created by Neosoft on 21/11/24.
//

import Foundation

final class DeleteCartViewModel {
    
    static var products: CartModel?
    func deleteCart(cartreq: DelCartRequest) {
        
        APIManager.shared.manager(modelType: CartModel.self, type: APIEndpoints.deleteCart, requestModel: cartreq , method: .post){
            result in
            switch result {
            case .success(let jsonData):
                print(jsonData)
                if let totalCart = Optional((jsonData as CartModel).total_carts){
                    UserDefaults.standard.set(totalCart, forKey: "CartTotal")
                }
            case .failure(_):
                
                print("Error:")
            }
        }
        
    }
  
}
