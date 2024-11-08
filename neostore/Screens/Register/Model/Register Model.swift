//
//  RegisterModel.swift
//  neostore
//
//  Created by Neosoft on 06/11/24.
//

import Foundation

struct RegisterModel: Codable {
    let status: Int?
    let data: RegistrationData?
    let message: String?
    let user_msg: String?
}

struct RegistrationData: Codable {
    var id: Int?
    var role_id: Int?
    var gender: String?
    var username: String?
    var created: String?
    var modified: String?
    var password: String?
    var confirm_password: String?
    var last_name: String?
    var email: String?
    var phone_no: String?
    var first_name: String?
    var access_token: String?
}
