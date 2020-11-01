//
//  ProductDetailInteractor.swift
//  ProductsEditor
//
//  Created by Mauro Romito on 01/11/2020.
//

import Foundation

protocol ProductDetailInteractorProtocol: AnyObject {
    var product: Product {get}
}

class ProductDetailInteractor {
    
    var product: Product
    
    init(model: Product) {
        self.product = model
    }
    
}

extension ProductDetailInteractor: ProductDetailInteractorProtocol {
    
}
