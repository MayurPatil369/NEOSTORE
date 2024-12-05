//
//  MyOrderModel.swift
//  neostore
//
//  Created by Neosoft on 28/11/24.
//

import Foundation


struct OrderListModel: Codable {
    let status: Int
    let data: [OrderData]
    let message: String
    let user_msg: String
}

struct OrderData: Codable {
    let id: Int
    let cost: Int
    let created: String
}
