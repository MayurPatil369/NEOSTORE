import Foundation
import Alamofire

protocol EndPointType {
    var baseURL: URL { get }
    var path: String { get }
    var url: URL? { get }
    var header: HTTPHeaders? { get }
}

extension EndPointType {
    var url: URL? {
        return baseURL.appendingPathComponent(path)
    }
}

enum APIEndpoints: EndPointType {
    
    case login
    case register
    
    var baseURL: URL {
        return URL(string: "http://staging.php-dev.in:8844/trainingapp/api/")!
    }
    
    var path: String {
        switch self {
        case .login:
            return "users/login"
        case .register:
            return "users/register"
        }
    }
    
    var header: HTTPHeaders? {
        if let token = UserDefaults.standard.string(forKey: "accessToken") {
            return [
                "Content-Type": "application/json",
                "Authorization": "Bearer \(token)"
            ]
        } else {
            return [
                "Content-Type": "application/json"
            ]
        }
    }
}
