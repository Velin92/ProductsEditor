//
//  ProductDetailViewState.swift
//  ProductsEditor
//
//  Created by Mauro Romito on 01/11/2020.
//

import Foundation


struct ProductDetailViewState {
    
    enum OperationState {
        case displaying
        case editing
        case adding
    }
    
    var images: [String] = []
    
    var productName: String = ""
    var merchantName: String = ""
    var url: String = ""
    
    var operationState: OperationState = .displaying
    
    init() {
        
    }
    
    init(from product: Product) {
        self.images = product.images
        self.productName = product.title
        self.merchantName = product.merchant
        self.url = product.url
    }
}
