//
//  productDetailsModel.swift
//  neostore
//
//  Created by Neosoft on 13/11/24.
//

import Foundation

struct productDetails : Codable {
    let status : Int?
    let data : productDetailsData?
}

struct productDetailsData : Codable {
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
    let product_images : [productImages]?
}

struct productImages : Codable {
    let id : Int?
    let product_id : Int?
    let image : String?
    let created : String?
    let modified : String?
}

struct productDetailsRequest : Codable {
    let product_id : Int?
}

 
 
