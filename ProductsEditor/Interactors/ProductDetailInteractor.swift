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
    var product: Product? {get}
    func updateProduct(name: String, merchant: String, url: String, images: [String], completion:@escaping ((Result<Product, ProductDetailError>)->()))
    func deleteProduct(completion:@escaping ((Result<Void, ProductDetailError>)->()))
}

class ProductDetailInteractor {
    
    var product: Product?
    let service: ProductDetailAPI
    
    init(model: Product?, service: ProductDetailAPI) {
        self.product = model
        self.service = service
    }
}

extension ProductDetailInteractor: ProductDetailInteractorProtocol {
    
    func deleteProduct(completion:@escaping ((Result<Void, ProductDetailError>)->())) {
        guard let product = product else {
            fatalError("Product should not be nil when this function is called")
        }
        service.deleteProduct(with: product.id) { result in
            switch result {
            case .success:
                completion(.success(()))
            case .failure(let error):
                completion(.failure(.genericError(error: error)))
            }
        }
    }
    
    func updateProduct(name: String, merchant: String, url: String, images: [String], completion:@escaping ((Result<Product, ProductDetailError>)->())) {
        guard let product = product else {
            let newProduct = Product(id: "", title: name, images: images, url: url, merchant: merchant)
            addNewProduct(newProduct, completion: completion)
            return
        }
        let updatedProduct = Product(id: product.id, title: name, images: images, url: url, merchant: merchant)
        updateProduct(updatedProduct, completion: completion)
    }
    
    private func updateProduct(_ updatedProduct: Product, completion:@escaping ((Result<Product, ProductDetailError>)->())) {
        service.updateProduct(updatedProduct) { [weak self] result in
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
    
    private func addNewProduct(_ newProduct : Product, completion:@escaping ((Result<Product, ProductDetailError>)->())) {
        service.createProduct(newProduct) { [weak self] result in
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
