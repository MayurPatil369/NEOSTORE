//
//  OrderDetailsViewModel.swift
//  neostore
//
//  Created by Neosoft on 27/11/24.
//

import Foundation


final class OrderDetailsVM {
    
    var details: OrderDetailsData?
    var eventHandler: ((_ event: Event) -> Void)?
  
    
    func getOrderDetails(dataTab: OrderDetailsRequest , id: Int){

        APIManager.shared.manager(modelType: OrderDetails.self, type: APIEndpoints.orderDetail(id), requestModel: dataTab, method: .get)
        {response in
            self.eventHandler?(.stopLoading)
            switch response {
            case .success(let details):
                self.details = details.data
                self.eventHandler?(.dataLoaded)
            case .failure(let error):
                print(error)
                self.eventHandler?(.error(error))
            }
        }
    }
}

extension OrderDetailsVM {
    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
    }
}
