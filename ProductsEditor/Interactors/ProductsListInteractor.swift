//
//  ProductsListInteractor.swift
//  ProductsEditor
//
//  Created by Mauro Romito on 31/10/2020.
//

import Foundation

enum ProductsListError: Error {
    case genericError(error: Error)
    case empty
}

protocol ProductsListInteractorProtocol: AnyObject {
    func fetchProducts(skip: Int, bulk: Int, completion: @escaping (Result<[Product], ProductsListError>)->())
    func getProduct(at index: Int) -> Product
}

class ProductsListInteractor {
    
    let service: ProductsListAPI
    
    var products: [Product] = []
    
    init(service: ProductsListAPI) {
        self.service = service
    }
}

extension ProductsListInteractor: ProductsListInteractorProtocol {
    
    func getProduct(at index: Int) -> Product {
        return products[index]
    }
    
    func fetchProducts(skip: Int, bulk: Int, completion: @escaping (Result<[Product], ProductsListError>) -> ()) {
        service.fetchProductsList(skip: skip, bulk: bulk) { [weak self] result in
            switch result {
            case .success(let response):
                guard let productsResponse = response.posts else {
                    completion(.failure(.empty))
                    return
                }
                let validProducts = productsResponse.compactMap(Product.init)
                self?.products = validProducts
                completion(.success(validProducts))
            case .failure(let error):
                completion(.failure(.genericError(error: error)))
            }
        }
    }
}
