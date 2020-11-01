//
//  ProductResponse.swift
//  ProductsEditor
//
//  Created by Mauro Romito on 01/11/2020.
//

import Foundation

typealias ProductResponse = ProductData

// MARK: - Post
struct ProductData: Codable {
    let id, createdAt, updatedAt, title: String?
    let images: [String]?
    let url: String?
    let merchant: String?
}

