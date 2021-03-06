//
//  APIClient.swift
//  ProductsEditor
//
//  Created by Mauro Romito on 01/11/2020.
//

import Foundation
import Alamofire

protocol ProductsListAPI {
    func fetchProductsList(skip: Int, bulk: Int, completion: @escaping (AFResult<ProductsListResponse>) -> Void )
}

protocol ProductDetailAPI {
    func updateProduct(_ product: Product,  completion: @escaping (AFResult<ProductResponse>) -> Void)
    func deleteProduct(with id: String, completion:  @escaping (AFResult<ProductResponse>) -> Void)
    func createProduct(_ product: Product,  completion: @escaping (AFResult<ProductResponse>) -> Void)
}

class APIClient {
    private func request<T: Codable> (_ urlConvertible: URLRequestConvertible, completion: @escaping (AFResult<T>) -> Void) {
        AF.request(urlConvertible).responseData() { (dataResponse: AFDataResponse<Data>) in
            let decoder = JSONDecoder()
            let response: AFResult<T> = decoder.decodeResponse(from: dataResponse)
            completion(response)
        }
    }
}

extension APIClient: ProductsListAPI {
    
    func fetchProductsList(skip: Int, bulk: Int, completion: @escaping (AFResult<ProductsListResponse>) -> Void) {
        let body = ProductsListOffsetRequest(skip: skip, take: bulk)
        request(APIRouter.productsList(request: body), completion: completion)
    }
}

extension APIClient: ProductDetailAPI {
    
    func createProduct(_ product: Product,  completion: @escaping (AFResult<ProductResponse>) -> Void) {
        let body = ProductCreateRequest(from: product)
        request(APIRouter.createProduct(request: body), completion: completion)
    }

    func deleteProduct(with id: String, completion: @escaping (AFResult<ProductResponse>) -> Void) {
        request(APIRouter.deleteProduct(request: ProductDeleteRequest(id: id)), completion: completion)
    }
    
    func updateProduct(_ product: Product, completion: @escaping (AFResult<ProductResponse>) -> Void) {
        let body = ProductUpdateRequest(from: product)
        request(APIRouter.updateProduct(request: body), completion: completion)
    }
}
