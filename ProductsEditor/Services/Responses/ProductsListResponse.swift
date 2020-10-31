//
//  ProductsListResponse.swift
//  ProductsEditor
//
//  Created by Mauro Romito on 01/11/2020.
//

import Foundation

// MARK: - ProductsListResponse
struct ProductsListResponse: Codable {
    let posts: [ProductData]?
}

// MARK: - Post
struct ProductData: Codable {
    let id, createdAt, updatedAt, title: String?
    let images: [String]?
    let url: String?
    let merchant: String?
}
