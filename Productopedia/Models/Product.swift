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
