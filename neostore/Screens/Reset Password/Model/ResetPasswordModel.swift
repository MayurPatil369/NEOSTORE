//
//  ResetPassModel.swift
//  neostore
//
//  Created by Neosoft on 26/11/24.
//

import Foundation

struct ResetRequest: Codable {
  let old_password: String
  let password: String
  let confirm_password: String
}

struct ResetResponse: Codable {
    let status: Int
    let data: [ResetData]
    let message: String
    let user_msg: String
}

struct ResetData: Codable {
    let id : Int?
    let role_id : Int?
    let first_name : String?
    let last_name : String?
    let email : String?
    let username : String?
    let profile_pic : String?
    let country_id : String?
    let gender : String?
    let phone_no : String?
    let dob : String?
    let is_active : Bool?
    let created : String?
    let modified : String?
    let access_token : String?
}
