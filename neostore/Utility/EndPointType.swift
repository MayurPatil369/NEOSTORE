//import Foundation
//import Alamofire
//
//protocol EndPointType {
//    var baseURL: URL { get }
//    var path: String { get }
//    var url: URL? { get }
//    var header: HTTPHeaders? { get }
//}
//
//extension EndPointType {
//    var url: URL? {
//        return baseURL.appendingPathComponent(path)
//    }
//}
//
//enum APIEndpoints: EndPointType {
//
//    case login
//    case register
//    case getProduct(Int)
//    case getDetail
//    case getUserDetails
//    case editDetails
//    case setRating
//    case addtoCart
//    case getCart
//    case editCart
//    case deleteCart
//
//    var baseURL: URL {
//        return URL(string: "http://staging.php-dev.in:8844/trainingapp/api/")!
//    }
//
//    var path: String {
//        switch self {
//        case .login:
//            return "users/login"
//        case .register:
//            return "users/register"
//        case let .getProduct(id):
//            return "products/getList?product_category_id=\(id)"
//        case .getDetail:
//            return "products/getDetail"
//        case .getUserDetails:
//            return "users/getUserData"
//        case .editDetails:
//            return "users/update"
//        case .setRating:
//            return "products/setRating"
//        case .addtoCart:
//            return "addToCart"
//        case .getCart:
//            return "cart"
//        case .editCart:
//            return "editCart"
//        case .deleteCart:
//            return "deleteCart"
//
//        }
//    }
//
//    var header: HTTPHeaders? {
//        switch self {
//        case .getUserDetails:
//            var headers = [String: String]()
//            if let token = UserDefaults.standard.string(forKey: "accessToken") {
//                headers["access_token"] = "\(token)"
//            }
//            return HTTPHeaders(headers)
//        default:
//            var headers: [String: String] = [
//                "accept": "application/json"
//            ]
//
//            if let token = UserDefaults.standard.string(forKey: "accessToken") {
//                headers["Authorization"] = "Bearer \(token)"
//            }
//            return HTTPHeaders(headers)
//        }
//    }
//}



import Foundation
import Alamofire

 

protocol EndPointType: Codable {
    var path: String { get }
    var baseURl: String { get }
    var url: URL? { get }
    var header: HTTPHeaders { get }
}

enum APIEndpoints {
    case register
    case login
    case getProduct(Int)
    case getDetail
    case setRating
    case addtoCart
    case getCart
    case editCart
    case deleteCart
    case getUserDetails
    case editDetails
    case forgotPass
    case resetPass
    case order
    case orderList
    case orderDetail(Int)
}

extension APIEndpoints: EndPointType{
    var header: Alamofire.HTTPHeaders {
    let headers: HTTPHeaders = [
            "access_token" : UserDefaults.standard.string(forKey: "accessToken") ?? ""]
        return headers
    }
    
    var path: String {
        switch self {
        case .register:
            return "users/register"
        case .login:
            return "users/login"
        case let .getProduct(id):
            return "products/getList?product_category_id=\(id)"
        case .getDetail:
            return "products/getDetail"
        case .setRating:
            return "products/setRating"
        case .addtoCart:
            return "addToCart"
        case .getCart:
            return "cart"
        case .editCart:
            return "editCart"
        case .deleteCart:
            return "deleteCart"
        case .getUserDetails:
            return "users/getUserData"
        case .editDetails:
            return "users/update"
        case .forgotPass:
            return "users/forgot"
        case .resetPass:
            return "users/change"
        case .order:
            return "order"
        case .orderList:
            return "orderList"
        case let .orderDetail(id):
            return "orderDetail?order_id=\(id)"
        }
    
    }
    
    var baseURl: String {
        return "http://staging.php-dev.in:8844/trainingapp/api/"
    }
    
    var url: URL? {
        return URL(string: "\(baseURl)\(path)")
    }
    
    
}
