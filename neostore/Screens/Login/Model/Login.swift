import Foundation

struct LoginModel: Codable {
    let email: String
    let password: String
}

struct LoginResponse: Codable {
    let status: Int?
    let data: LoginData?
    let message: String?
    let userMessage: String?

    private enum CodingKeys: String, CodingKey {
        case status, data, message
        case userMessage = "user_msg"
    }
}

struct LoginData: Codable {
    let id: Int?
    let roleID: Int?
    let firstName: String?
    let lastName: String?
    let email: String?
    let username: String?
    let profilePic: String?
    let countryID: String?
    let gender: String?
    let phoneNo: String?
    let dob: String?
    let isActive: Bool?
    let created: String?
    let modified: String?
    let accessToken: String?

    private enum CodingKeys: String, CodingKey {
        case id, roleID = "role_id", firstName = "first_name", lastName = "last_name", email, username
        case profilePic = "profile_pic", countryID = "country_id", gender, phoneNo = "phone_no", dob
        case isActive = "is_active", created, modified, accessToken = "access_token"
    }


}
