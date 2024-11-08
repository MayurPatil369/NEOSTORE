

import Foundation
 import Alamofire
 
 enum DataError: Error {
 case invalidResponse
 case invalidDecoding
 case invalidURL
 case invalidData
 case network(String)
 }
 
 typealias Handler<T> = (Result<T, DataError>) -> Void
 
 final class APIManager {
 static let shared = APIManager()
 private init() {}
 
 func request<T: Codable, U: Codable>(
 modelType: T.Type,
 endpoint: EndPointType,
 requestModel: U?,
 method: HTTPMethod,
 completion: @escaping Handler<T>
 ) {
 
 guard let url = endpoint.url else {
 completion(.failure(.invalidURL))
 return
 }
 
     AF.request(url , method: method,parameters: requestModel,encoder: URLEncodedFormParameterEncoder.default).response{
           
           response in
           switch response.result {
               
           case .success(let data):
               do{
                   if response.response?.statusCode == 200 {
                       let decoder = JSONDecoder()
                       if let decoded = try? decoder.decode(T.self, from: data!) {
                           completion(.success(decoded))
                       }
                       else {
                           completion(.failure(.invalidData))
                       }
                   }
               }
               
           case .failure:
               completion(.failure(.network("invalid")))
           }
       }
 }
 }
 
 


