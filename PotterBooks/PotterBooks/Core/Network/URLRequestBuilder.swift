//
//  URLRequestBuilder.swift
//  PotterBooks
//
//  Created by Rohit Chugh on 25/10/25.
//

import Foundation

//MARK: HTTPMethod
enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
    case PATCH
}

//MARK: URLRequestBuilder
protocol URLRequestBuilder {
    var baseURL: String { get }
    
    var endPoint: String { get }
    
    var httpMethod: HTTPMethod { get }
    
    var headers: [String:String]? { get }
    
    var requestBody: Data? { get }
}

extension URLRequestBuilder {
    
    var baseURL: String {
        return URLConstants.baseURL
    }
    
    var headers: [String : String]? {
        return [:]
    }
    
    func urlRequest() -> URLRequest {
        var urlRequest = URLRequest(url: URL(string: self.baseURL.appending(endPoint))!)
        
        urlRequest.httpMethod = self.httpMethod.rawValue
        urlRequest.httpBody = self.requestBody
        urlRequest.allHTTPHeaderFields = self.headers
        
        return urlRequest
    }
}
