//
//  productDetailsViewModel.swift
//  neostore
//
//  Created by Neosoft on 13/11/24.
//

import Foundation

 class ProductDetailViewModel {
    
    var products: productDetailsData?
     
    var eventHandler: ((_ event: Event) -> Void)?
    
     func fetchProducts(dataTab: productDetailsRequest){

        APIManager.shared.manager(modelType: productDetails.self, type: APIEndpoints.getDetail, requestModel: dataTab, method: .get)
            {response in
            self.eventHandler?(.stopLoading)
            switch response {
            case .success(let products):
                self.products = products.data
                self.eventHandler?(.dataLoaded)
                
                
            case .failure(let error):
                print(error)
                self.eventHandler?(.error(error))
            }
        }
    }
}

extension ProductDetailViewModel {
    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
    }
}
