//
//  RegisterViewModel.swift
//  neostore
//

import Foundation

final class RegisterViewModel {
    
    var onSuccess: (() -> Void)?
    var onFailure: ((String) -> Void)?
    
    func registerUser(with data: RegistrationData) {
        APIManager.shared.manager(
            modelType: RegisterModel.self,
            type: APIEndpoints.register,
            requestModel: data,
            method: .post
        ) {  result in
            switch result {
            case .success(let responseData):
                print("User Registration Success:", responseData)
                self.onSuccess?()
            case .failure(let error):
                print("Registration Error:", error.localizedDescription)
                self.onFailure?(error.localizedDescription)
            }
        }
    }
}
