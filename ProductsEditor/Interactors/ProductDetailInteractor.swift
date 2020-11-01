//
//  ProductDetailInteractor.swift
//  ProductsEditor
//
//  Created by Mauro Romito on 01/11/2020.
//

import Foundation

enum ProductDetailError: Error {
    case invalidResponse
    case genericError(error: Error)
}

protocol ProductDetailInteractorProtocol: AnyObject {
    var product: Product {get}
    func updateProduct(name: String, merchant: String, url: String, images: [String], completion:@escaping ((Result<Product, ProductDetailError>)->()))
}

class ProductDetailInteractor {
    
    var product: Product
    let service: ProductDetailAPI
    
    init(model: Product, service: ProductDetailAPI) {
        self.product = model
        self.service = service
    }
}

extension ProductDetailInteractor: ProductDetailInteractorProtocol {
    func updateProduct(name: String, merchant: String, url: String, images: [String], completion:@escaping ((Result<Product, ProductDetailError>)->())) {
        let newProduct = Product(id: product.id, title: name, images: images, url: url, merchant: merchant)
        service.updateProduct(newProduct) { [weak self] result in
            switch result {
            case .success(let response):
                guard let product = Product(from: response) else {
                    completion(.failure(.invalidResponse))
                    return
                }
                self?.product = product
                completion(.success(product))
            case .failure(let error):
                completion(.failure(.genericError(error: error)))
            }
        }
    }
}
