//
//  MyOrderViewModel.swift
//  neostore
//
//  Created by Neosoft on 28/11/24.
//

import Foundation

final class OrderListViewModel {
    
    var details: [OrderData] = []
    var eventHandler: ((_ event: Event) -> Void)?
    
    func getOrder(dataTab: ProdRequest){
        APIManager.shared.manager(modelType: OrderListModel.self, type: APIEndpoints.orderList, requestModel: dataTab, method: .get)
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

extension OrderListViewModel {
    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
    }
}
