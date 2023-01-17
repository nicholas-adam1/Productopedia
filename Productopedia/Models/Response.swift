//
//  Response.swift
//  Productopedia
//
//  Created by Nick Adam on 1/17/23.
//

import Foundation

struct Response : Decodable {
    let products: [Product]
    let total: Int
    let skip: Int
    let limit: Int
}
