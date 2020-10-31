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
        request(APIRouter.productsList(offsetRequest: body), completion: completion)
    }
}
