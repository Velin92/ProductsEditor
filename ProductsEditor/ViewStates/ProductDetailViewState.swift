//
//  ProductDetailViewState.swift
//  ProductsEditor
//
//  Created by Mauro Romito on 01/11/2020.
//

import Foundation

struct ProductDetailViewState {
    
    var images: [String] = []
    
    var productName: String = ""
    var merchantName: String = ""
    
    init() {
        
    }
    
    init(from product: Product) {
        self.images = product.images
        self.productName = product.title
        self.merchantName = product.merchant
    }
}
