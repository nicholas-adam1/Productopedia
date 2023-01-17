//
//  ProductScreen.swift
//  Productopedia
//
//  Created by Nick Adam on 1/13/23.
//

import UIKit

class ProductScreen: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var data = Product(id: 0, title: "", description: "", price: 0, rating: 0.0, brand: "", thumbnail: "", images: [""])
    
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    let textView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        return textView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpCollectionView()
        setUpTextView()
    }
    
    // MARK: - Collection View
    
    func setUpCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: view.frame.width, height: view.frame.height/2)
        
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CarouselCell.self, forCellWithReuseIdentifier: CarouselCell.identifier)
        collectionView.isPagingEnabled = true
        
        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.widthAnchor.constraint(equalToConstant: view.frame.width),
            collectionView.heightAnchor.constraint(equalToConstant: view.frame.height/2)
        ])
    }
 
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarouselCell.identifier, for: indexPath) as! CarouselCell
        
        let imageURL = URL(string: data.images[indexPath.row])!
        URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
            if let error = error {
                print(error)
                cell.imageView.image = UIImage(systemName: "exclamationmark.triangle")
            }
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    cell.imageView.image = image
                }
            }
        }.resume()
        return cell
    }
    
    // MARK: - Text View
    
    func setUpTextView() {
        view.addSubview(textView)
        
        textView.text = "\(data.title)\n\n\(data.brand)\n\nPrice: $\(data.price)\n\nRating: \(data.rating)/5\n\n\(data.description)"
        textView.font = .systemFont(ofSize: 20)

        textView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            textView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }


}
