//
//  CartListViewModel.swift
//  neostore
//
//  Created by Neosoft on 21/11/24.
//

import Foundation

final class ListCartViewModel {
    
    var products: [ListCartData] = []
    var model: Int?
    var eventHandler: ((_ event: Event) -> Void)?
    
    func fetchCart(dataTab: CartRequest){

        APIManager.shared.manager(modelType: ListCartModel.self, type: APIEndpoints.getCart, requestModel: emptyRequest(), method: .get)
            {
              response in
            self.eventHandler?(.stopLoading)
            switch response {
            case .success(let products):
                self.products = products.data
                UserDefaults.standard.set(products.total, forKey: "CartAmt")
                self.eventHandler?(.dataLoaded)
            case .failure(let error):
                print(error)
                self.eventHandler?(.error(error))
            }
        }
    }
}

extension ListCartViewModel {
    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
    }
}
