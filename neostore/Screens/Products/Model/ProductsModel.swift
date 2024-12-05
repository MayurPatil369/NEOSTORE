//
//  ProductListModel.swift
//  neostore
//
//  Created by Neosoft on 11/11/24.
//

import Foundation

struct ProductListModel: Codable {
    let status: Int?
    let data: ProdListData?
}

struct ProdListData: Codable {
    let id : Int?
    let product_category_id : Int?
    let name : String?
    let producer : String?
    let description : String?
    let cost : Int?
    let rating : Int?
    let view_count : Int?
    let created : String?
    let modified : String?
    let product_images : [Product_images]?
}

struct Product_images: Codable {
    let id : Int?
    let product_id : Int?
    let image : String?
    let created : String?
    let modified : String?
}

struct ProductListRequest: Codable {
    let product_id: String?
}
