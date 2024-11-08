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

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        data = try values.decodeIfPresent(LoginData.self, forKey: .data)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        userMessage = try values.decodeIfPresent(String.self, forKey: .userMessage)
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

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        roleID = try values.decodeIfPresent(Int.self, forKey: .roleID)
        firstName = try values.decodeIfPresent(String.self, forKey: .firstName)
        lastName = try values.decodeIfPresent(String.self, forKey: .lastName)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        username = try values.decodeIfPresent(String.self, forKey: .username)
        profilePic = try values.decodeIfPresent(String.self, forKey: .profilePic)
        countryID = try values.decodeIfPresent(String.self, forKey: .countryID)
        gender = try values.decodeIfPresent(String.self, forKey: .gender)
        phoneNo = try values.decodeIfPresent(String.self, forKey: .phoneNo)
        dob = try values.decodeIfPresent(String.self, forKey: .dob)
        isActive = try values.decodeIfPresent(Bool.self, forKey: .isActive)
        created = try values.decodeIfPresent(String.self, forKey: .created)
        modified = try values.decodeIfPresent(String.self, forKey: .modified)
        accessToken = try values.decodeIfPresent(String.self, forKey: .accessToken)
    }
}
