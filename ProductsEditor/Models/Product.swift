//
//  Product.swift
//  ProductsEditor
//
//  Created by Mauro Romito on 01/11/2020.
//

import Foundation

struct Product {
    let id: String
    let title: String
    let images: [String]
    let url: String
    let merchant: String
    
    init? (from data: ProductData) {
        //I CONSIDER ONLY THE ID AND THE TITLE TO BE NECESSARY FOR DISPLAYING
        guard let id = data.id,
              !id.isEmpty,
              let title = data.title,
              !title.isEmpty else {return nil}
        self.id = id
        self.title = title
        self.images = data.images ?? []
        self.url = data.url ?? ""
        self.merchant = data.merchant ?? ""
    }
    
    init(id: String, title: String, images: [String], url: String, merchant: String) {
        self.id = id
        self.title = title
        self.images = images
        self.url = url
        self.merchant = merchant
    }
}
