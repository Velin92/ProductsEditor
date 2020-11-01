//
//  APIRouter.swift
//  ProductsEditor
//
//  Created by Mauro Romito on 31/10/2020.
//

import Foundation
import Alamofire

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
}

enum Constants {
    static let baseURLPath = "http://localhost:3000"
}

enum APIRouter: URLRequestConvertible {
    case productsList(offsetRequest: ProductsListOffsetRequest)
    case updateProduct(request: ProductUpdateRequest)
    
    var method: HTTPMethod {
        switch self {
        case .productsList, .updateProduct:
            return .post
        }
    }
    
    var path: String {
        
        switch self {
        case .productsList:
            return "/products/offset"
        case .updateProduct:
            return "/product/update"
        }
    }
    
    var encoding: ParameterEncoding {
        switch method {
        case .get:
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try Constants.baseURLPath.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        
        if method == .post {
            do {
                urlRequest.httpBody = try encodeRequest()
            }
            catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
            print("POST request url:\n \(String(describing: urlRequest.url?.absoluteString))")
            print("BODY:\n \(String(data: urlRequest.httpBody!, encoding: .utf8) ?? "nil")")
            return urlRequest
            
        }
        else {
            print("GET request url\n: \(String(describing: urlRequest.url?.absoluteString))")
            return urlRequest
        }
    }
    
    private func encodeRequest() throws -> Data  {
        switch self {
        case .productsList(let request):
            return try JSONEncoder().encode(request)
        case .updateProduct(let request):
            return try JSONEncoder().encode(request)
        }
    }
}
