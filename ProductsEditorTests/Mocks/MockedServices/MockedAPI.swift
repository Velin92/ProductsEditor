//
//  MockedAPI.swift
//  ProductsEditorTests
//
//  Created by Mauro Romito on 02/11/2020.
//

import Foundation
import Alamofire
@testable import ProductsEditor

class MockedService: ProductsListAPI, ProductDetailAPI {
    
    var mockedJson: String
    var isFailureTest = false
        
    init(mockedJson: String, isFailureTest: Bool) {
        self.mockedJson = mockedJson
        self.isFailureTest = isFailureTest
    }
    
    func fetchProductsList(skip: Int, bulk: Int, completion: @escaping (AFResult<ProductsListResponse>) -> Void) {
        if !isFailureTest {
            let response = try! JSONDecoder().decode(ProductsListResponse.self, from: Data(contentsOf: Bundle(for: type(of: self)).url(forResource: mockedJson, withExtension: "json")!))
            completion(AFResult<ProductsListResponse>.success(response))
        } else {
            completion(AFResult<ProductsListResponse>.failure(AFError.sessionTaskFailed(error: "Test error")))
        }
    }
    
    func updateProduct(_ product: Product, completion: @escaping (AFResult<ProductResponse>) -> Void) {
        
    }
    
    func deleteProduct(with id: String, completion: @escaping (AFResult<ProductResponse>) -> Void) {
        
    }
    
    func createProduct(_ product: Product, completion: @escaping (AFResult<ProductResponse>) -> Void) {
        
    }
}
