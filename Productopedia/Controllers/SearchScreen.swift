//
//  ViewController.swift
//  Productopedia
//
//  Created by Nick Adam on 1/12/23.
//

import UIKit

class SearchScreen: UIViewController, UISearchBarDelegate {
    
    var searchField = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Productopedia"
        setupSearchField()
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setupSearchField() {
        searchField.delegate = self
        view.addSubview(searchField)
        
        searchField.frame = CGRect(x: 0, y: 150, width: view.frame.width, height: 50)
        searchField.isTranslucent  = false
        searchField.tintColor  = .gray
        searchField.placeholder = "Search for a product"
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let searchURL: URL? = URL(string: "https://dummyjson.com/products/search?q=\(searchBar.text)")
        
        if let url = searchURL {
            APIHandler.shared.getData(url: url) { (data, error) in
                if let error = error {
                    print(error)
                }
                guard let data = data else { return }
                
            }
        } else {
            return
        }
    }
    


}

