//
//  ProductCreateRequest.swift
//  ProductsEditor
//
//  Created by Mauro Romito on 02/11/2020.
//

import Foundation

// MARK: - ProductCreateRequest
struct ProductCreateRequest: Codable {
    let title: String
    let images: [String]
    let url, merchant: String
    
    init(from product: Product) {
        self.title = product.title
        self.images = product.images
        self.url = product.url
        self.merchant = product.merchant
    }
}
