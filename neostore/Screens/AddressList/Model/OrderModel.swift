//
//  OrderModel.swift
//  neostore
//
//  Created by Neosoft on 27/11/24.
//

import Foundation

struct OrderModel: Codable {
    
    let status: Int
    let message: String
    let user_msg: String
    
}

struct OrderRequest: Codable {
    let address: String
}
