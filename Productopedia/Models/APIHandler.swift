//
//  APIHandler.swift
//  Productopedia
//
//  Created by Nick Adam on 1/13/23.
//

import Foundation

class APIHandler {
    static let shared = APIHandler()
    private init() {}
    func getData(url: URL, completion: @escaping (Data?, Error?) -> Void) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }.resume()
    }
}
