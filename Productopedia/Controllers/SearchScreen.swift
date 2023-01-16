//
//  ViewController.swift
//  Productopedia
//
//  Created by Nick Adam on 1/12/23.
//

import UIKit

class SearchScreen: UIViewController, UISearchBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var products : [Product] = []
    let searchField = UISearchBar()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Productopedia"
        setupSearchField()
        setUpCollectionView()
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    // Collection View
    
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
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCollectionViewCell.identifier, for:  indexPath) as! ProductCollectionViewCell
        
        cell.textView.text = "\(products[indexPath.row].title)\n\n\(products[indexPath.row].brand)\n\n$\(products[indexPath.row].price)"
        
        let imageURL = URL(string: products[indexPath.row].images[0])!
        URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    cell.imageView.image = image
                }
            }
        }.resume()
        return cell
    }
    
    // Search Field
    
    func setupSearchField() {
        view.addSubview(searchField)
        searchField.delegate = self
        
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
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        let searchURL: URL? = URL(string: "https://dummyjson.com/products/search?q=\(text)")
        
        if let url = searchURL {
            APIHandler.shared.getData(url: url) { (data, error) in
                if let error = error {
                    print(error)
                }
                guard let data = data else { return }
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(Response.self, from: data)
                    self.products = response.products
                    self.collectionView.reloadData()
                } catch {
                    return
                }
            }
        } else {
            return
        }
    }
    


}

