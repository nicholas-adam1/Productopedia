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
    let errorLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Productopedia"
        setupSearchField()
        setUpCollectionView()
        setUpErrorLabel()
        view.backgroundColor = UIColor(hue: 0.4944, saturation: 0.41, brightness: 0.8, alpha: 1.0)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    // MARK: - Collection View
    
    func setUpCollectionView() {
        view.addSubview(collectionView)
        collectionView.register(ProductCollectionViewCell.self, forCellWithReuseIdentifier: ProductCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.estimatedItemSize = CGSize(width: (view.frame.size.width/2) - 8,height: 95)
        flowLayout.minimumLineSpacing = 2
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
        
        let imageURL = URL(string: products[indexPath.row].thumbnail)!
        URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
            if let error = error {
                print(error)
                cell.imageView.image = UIImage(systemName: "exclamationmark.triangle")
                cell.textView.text = "\(self.products[indexPath.row].title)\n\n\(self.products[indexPath.row].brand)"
            }
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    cell.imageView.image = image
                    cell.textView.text = "\(self.products[indexPath.row].title)\n\n\(self.products[indexPath.row].brand)"
                    cell.layer.borderWidth = 3
                    cell.layer.borderColor = CGColor(gray: 0.9, alpha: 1)
                }
            } 
        }.resume()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let nextScreen = ProductScreen()
        nextScreen.data = products[indexPath.row]
        present(nextScreen, animated: true, completion: nil)
    }
    
    // MARK: - Search Field
    
    func setupSearchField() {
        view.addSubview(searchField)
        searchField.delegate = self
        searchField.isTranslucent  = false
        searchField.tintColor  = .gray
        searchField.barTintColor = UIColor(hue: 0.4944, saturation: 0.41, brightness: 0.8, alpha: 1.0)
        searchField.layer.borderWidth = 1
        searchField.layer.borderColor = UIColor(hue: 0.4944, saturation: 0.41, brightness: 0.8, alpha: 1.0).cgColor
        searchField.placeholder = "Search for a product"
        
        searchField.translatesAutoresizingMaskIntoConstraints = false
                
        NSLayoutConstraint.activate([
            searchField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchField.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchField.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text?.trimmingCharacters(in: .whitespaces) else { return }
        let searchURL: URL? = URL(string: "https://dummyjson.com/products/search?q=\(text)")
        
        if let url = searchURL {
            APIHandler.shared.getData(url: url) { (data, error) in
                if let error = error {
                    print(error)
                    self.errorLabel.isHidden = false
                }
                guard let data = data else { return }
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(Response.self, from: data)
                    self.products = response.products
                    self.collectionView.reloadData()
                    self.errorLabel.isHidden = true
                } catch {
                    return
                }
            }
        } else {
            return
        }
    }
    
    // MARK: - Error Label
    
    func setUpErrorLabel() {
        view.addSubview(errorLabel)
        
        errorLabel.text = "An error occurred while searching"
        errorLabel.textColor = .red
        errorLabel.numberOfLines = 0
        errorLabel.textAlignment = .center
        errorLabel.isHidden = true
        
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            errorLabel.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }
    


}

