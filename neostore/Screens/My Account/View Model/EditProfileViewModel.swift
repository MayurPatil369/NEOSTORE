//
//  EditProfileViewModel.swift
//  neostore
//
//  Created by Neosoft on 19/11/24.
//


import Foundation

final class EditProfileViewModel {
    func editRequest(logs: EditRequest, completion: @escaping (Result<EditResponse, Error>) -> Void) {
        APIManager.shared.manager(
            modelType: EditResponse.self,
            type: APIEndpoints.editDetails,
            requestModel: logs,
            method: .post
        ) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
