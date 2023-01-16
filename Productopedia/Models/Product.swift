//
//  Product.swift
//  Productopedia
//
//  Created by Nick Adam on 1/16/23.
//

import Foundation

struct Product : Decodable {
    let id: Int
    let title: String
    let description: String
    let price: Int
    let rating: Double
    let brand: String
    let thumbnail: String
    let images: [String]
}

struct Response : Decodable {
    let products: [Product]
    let total: Int
    let skip: Int
    let limit: Int
}
