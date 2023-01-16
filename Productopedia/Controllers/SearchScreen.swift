//
//  ViewController.swift
//  Productopedia
//
//  Created by Nick Adam on 1/12/23.
//

import UIKit

class SearchScreen: UIViewController, UISearchBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var searchField = UISearchBar()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Productopedia"
        setupSearchField()
        setUpCollectionView()
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setUpCollectionView() {
        view.addSubview(collectionView)
        collectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: ProductCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.estimatedItemSize = CGSize(width: 190,height: 95)
        collectionView.collectionViewLayout = flowLayout
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: searchField.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.identifier, for:  indexPath) as! ProductCollectionViewCell
        cell.textView.text = "hello"
        return cell
    }
    
    func setupSearchField() {
        searchField.delegate = self
        view.addSubview(searchField)
        
        searchField.translatesAutoresizingMaskIntoConstraints = false
                
        NSLayoutConstraint.activate([
            searchField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchField.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchField.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        searchField.isTranslucent  = false
        searchField.tintColor  = .gray
        searchField.placeholder = "Search for a product"
        
    }
    
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        let searchURL: URL? = URL(string: "https://dummyjson.com/products/search?q=\(searchBar.text)")
//
//        if let url = searchURL {
//            APIHandler.shared.getData(url: url) { (data, error) in
//                if let error = error {
//                    print(error)
//                }
//                guard let data = data else { return }
//
//            }
//        } else {
//            return
//        }
//    }
    


}

