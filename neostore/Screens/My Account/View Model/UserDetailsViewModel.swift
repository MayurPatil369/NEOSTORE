//
//  UserDetailsViewModel.swift
//  neostore
//
//  Created by Neosoft on 19/11/24.
//

import Foundation


final class UserDetailsViewModel {
    
    var details: UserData?
    var eventHandler: ((_ event: Event) -> Void)?
    
    func getDetails(dataTab: EmptyRequest){
        APIManager.shared.manager(modelType: UserModel.self, type: APIEndpoints.getUserDetails, requestModel: dataTab, method: .get)
        {response in
            self.eventHandler?(.stopLoading)
            switch response {
            case .success(let details):
                self.details = details.data
                UserDefaults.standard.set(details.data?.user_data?.username, forKey: "Name")
                UserDefaults.standard.set(details.data?.total_carts, forKey: "CartTotal")
                self.eventHandler?(.dataLoaded)
            case .failure(let error):
                print(error)
                self.eventHandler?(.error(error))
            }
        }
    }
}

extension UserDetailsViewModel {
    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
    }
}
