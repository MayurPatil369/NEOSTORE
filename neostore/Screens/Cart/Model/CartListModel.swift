//
//  CartListModel.swift
//  neostore
//
//  Created by Neosoft on 21/11/24.
//

import Foundation

struct ListCartModel : Codable {
    let status : Int
    let data : [ListCartData]
    let count : Int
    let total : Int
}

struct ListCartData : Codable {
    let id : Int
    let product_id : Int
    let quantity : Int
    let product : ListCartProduct
}

struct ListCartProduct : Codable {
    let id : Int
    let name : String
    let cost : Int
    let product_category : String
    let product_images : String
    let sub_total : Int
}
