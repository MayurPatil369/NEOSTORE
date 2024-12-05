//
//  RatingPopUpViewModel.swift
//  neostore
//
//  Created by Neosoft on 20/11/24.


import Foundation

final class RatingPopUpViewModel {

    func rateRequest(logs: RatingRequest, completion: @escaping (Bool) -> Void) {
        APIManager.shared.manager(modelType: RatingResponse.self, type: APIEndpoints.setRating, requestModel: logs, method: .post) { result in
            switch result {
            case .success(let jsonData):
                guard let data = jsonData.data else {
                    completion(false)
                    return
                }
                if let id = data.id, let rating = data.rating {
                    UserDefaults.standard.set(rating, forKey: "prodRating \(id)")
                    completion(true)
                } else {
                    completion(false)
                }
            case .failure:
                completion(false)
            }
        }
    }
}
