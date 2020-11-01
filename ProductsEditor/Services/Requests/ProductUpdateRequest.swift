//
//  ProductUpdateRequest.swift
//  ProductsEditor
//
//  Created by Mauro Romito on 01/11/2020.
//

import Foundation

// MARK: - ProductUpdateRequest
struct ProductUpdateRequest: Codable {
    let id, title: String
    let images: [String]
    let url, merchant: String
    
    init(from product: Product) {
        self.id = product.id
        self.title = product.title
        self.images = product.images
        self.url = product.url
        self.merchant = product.merchant
    }
}
