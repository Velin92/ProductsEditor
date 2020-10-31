//
//  JSONDecoder+decodeResponse.swift
//  ProductsEditor
//
//  Created by Mauro Romito on 01/11/2020.
//

import Foundation
import Alamofire

extension JSONDecoder {
    
    func decodeResponse<T: Decodable>(from response: AFDataResponse<Data>) -> AFResult<T> {
        guard response.error == nil else {
            print(response.error!)
            return .failure(response.error!)
        }
        
        guard let responseData = response.data else {
            print("didn't get any data from API")
            return .failure(AFError.responseValidationFailed(reason: .dataFileNil))
        }
        
        do {
            let item = try decode(T.self, from: responseData)
            if let stringResponse = String(data: responseData, encoding: .utf8) {
                print("BE RESPONSE:\n\(stringResponse)")
            }
            return .success(item)
        } catch {
            print("error trying to decode response")
            print(error)
            return AFResult.failure(AFError.responseSerializationFailed(reason: .decodingFailed(error: error)))
        }
    }
}
