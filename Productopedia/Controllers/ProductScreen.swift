//
//  ProductScreen.swift
//  Productopedia
//
//  Created by Nick Adam on 1/13/23.
//

import UIKit

class ProductScreen: UIViewController {
    
    var data = Product(id: 0, title: "", description: "", price: 0, rating: 0.0, brand: "", thumbnail: "", images: [""])
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    let textView: UITextView = {
        let textView = UITextView()
        return textView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(imageView)
        view.addSubview(textView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.widthAnchor.constraint(equalToConstant: view.frame.width),
            textView.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            textView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        let imageURL = URL(string: data.thumbnail)!
        URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
            if let error = error {
                print(error)
            }
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            } else {
                return
            }
        }.resume()
        
        textView.text = "\(data.title)\n\n\(data.brand)\n\nPrice: $\(data.price)\n\nRating: \(data.rating)/5\n\n\(data.description)"
        
    }


}
