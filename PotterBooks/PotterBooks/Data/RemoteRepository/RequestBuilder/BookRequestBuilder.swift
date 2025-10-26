//
//  BookRequestBuilder.swift
//  PotterBooks
//
//  Created by Rohit Chugh on 26/10/25.
//

import Foundation

enum BookRequestBuilder {
    case books
    case search(Encodable)
}

extension BookRequestBuilder: URLRequestBuilder {
    
    var httpMethod:HTTPMethod {
        switch self {
        case .search(_), .books:
            return .GET
        }
    }

    var requestBody:Data? {
        switch self {
        case .search(_), .books:
            return nil
        }
    }

    var endPoint:String {
        switch self {
        case .search(let searchRequest):
            return "/books?".appending(searchRequest.getURLQuery())
        case .books:
            return "/books"
        }
    }
}
