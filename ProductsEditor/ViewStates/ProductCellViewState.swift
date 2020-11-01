//
//  ProductCellViewState.swift
//  ProductsEditor
//
//  Created by Mauro Romito on 31/10/2020.
//

import Foundation

struct ProductCellViewState {
    let title: String
    let defaultImage: String
    
    init(from product: Product) {
        self.title = product.title
        self.defaultImage = product.images.first ?? ""
    }
}

typealias ProductsListViewState = [ProductCellViewState]
