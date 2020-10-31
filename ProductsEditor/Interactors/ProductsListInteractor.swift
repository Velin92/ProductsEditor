//
//  ProductsListInteractor.swift
//  ProductsEditor
//
//  Created by Mauro Romito on 31/10/2020.
//

import Foundation

protocol ProductsListInteractorProtocol: AnyObject {
    
}

class ProductsListInteractor {
    
    let service: ProductsListAPI
    
    init(service: ProductsListAPI) {
        self.service = service
    }
}

extension ProductsListInteractor: ProductsListInteractorProtocol {
    
}
