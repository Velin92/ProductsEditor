//
//  ProductListOffsetRequest.swift
//  ProductsEditor
//
//  Created by Mauro Romito on 31/10/2020.
//


import Foundation

// MARK: - ProductsListOffsetRequest
struct ProductsListOffsetRequest: Codable {
    let skip, take: Int
}
