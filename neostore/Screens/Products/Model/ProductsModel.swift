//
//  ProductListModel.swift
//  neostore
//
//  Created by Neosoft on 11/11/24.
//
import Foundation

struct Product: Codable {
    let status: Int
    let data: [ProdData]
}

struct ProdData: Codable {
    let id: Int
    let product_category_id: Int
    let name: String
    let producer: String
    let description: String
    let cost: Int
    let rating: Int
    let view_count: Int
    let created: String
    let modified: String
    let product_images: String
}

struct ProdRequest: Codable {
    let product_category_id: Int
   
}



