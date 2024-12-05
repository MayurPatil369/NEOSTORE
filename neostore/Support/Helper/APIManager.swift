
import Foundation
import Alamofire
import UIKit

enum DataError: Error {
    case invalidResponse(String)
    case invalidDecoding
    case invalidURL
    case invalidData
    case network(String)
    
    var localizedError: String {
        switch self {
        case .invalidResponse(let asg):
            return asg
        default:
            return ""
        }
    }
}

struct CommonModel: Codable {
    let status: Int
    let message: String
    let user_msg: String
}

typealias Handler<T> = (Result<T, DataError>) -> Void

final class APIManager {
    static let shared = APIManager()
    private init() {}
    
    func manager<T: Codable, U: Codable>(
        modelType: T.Type,
        type: EndPointType,
        requestModel: U?,
        method: HTTPMethod,
        completion: @escaping Handler<T>
    ) {
        let headers = type.header
        guard var url = type.url else {
            completion(.failure(.invalidURL))
            return
        }
        var stringUrl = "\(url)"
        stringUrl = stringUrl.replacingOccurrences(of: "%3F", with: "?")
        url = URL(string: stringUrl)!
        
        AF.request(url, method: method, parameters: requestModel, encoder: URLEncodedFormParameterEncoder.default, headers: headers).response { response in
            switch response.result {
            case .success(let data):
                do {
                    if response.response?.statusCode == 200 {
                        let decoder = JSONDecoder()
                        if let decoded = try? decoder.decode(T.self, from: data!) {
                            completion(.success(decoded))
                        } else {
                            completion(.failure(.invalidData))
                        }
                    } else {
                        if let error = data {
                            do {
                                let apiError = try JSONDecoder().decode(CommonModel.self, from: error)
                                print("Client error: \(apiError.message)")
                                completion(.failure(.invalidResponse(apiError.message)))
                            } catch {
                                print("Failed to decode error message")
                            }
                        }
                    }
                }
                
            case .failure(_):
                completion(.failure(.network("Request failed")))
            }
        }
    }
}

