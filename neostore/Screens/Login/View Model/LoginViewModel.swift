import Foundation
import UIKit

final class LoginViewModel {
    var eventHandler: ((Event) -> Void)?
    
    
    func getRequest(logs: LoginModel) {
        APIManager.shared.manager(modelType: LoginResponse.self, type: APIEndpoints.login, requestModel: logs, method: .post) { [weak self] (result: Result<LoginResponse, DataError>) in

            
            switch result {
            case .success(let responseData):
                if let token = responseData.data?.accessToken {
                    UserDefaults.standard.set(token, forKey: "accessToken")
                }
                
                if let firstName = responseData.data?.firstName,
                   let lastName = responseData.data?.lastName {
                    let fullName = "\(firstName) \(lastName)"
                    UserDefaults.standard.set(fullName, forKey: "fullname")
                }
                
                if let email = responseData.data?.email {
                    UserDefaults.standard.set(email, forKey: "username")
                }
                
                self?.eventHandler?(.dataLoaded)
                
            case .failure(let error):
                
                self?.eventHandler?(.error(error))
            }
        }
    }
}

extension LoginViewModel {
    enum Event {
        case loading
        case stopLoading
        case dataLoaded
        case error(Error?)
    }
}
