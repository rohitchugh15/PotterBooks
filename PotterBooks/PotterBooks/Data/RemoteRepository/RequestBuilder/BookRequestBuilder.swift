//
//  BookRequestBuilder.swift
//  PotterBooks
//
//  Created by Rohit Chugh on 26/10/25.
//

import Foundation

enum BookRequestBuilder {
    case books
    case search(String)
}

extension BookRequestBuilder: URLRequestBuilder {
    
    var httpMethod:HTTPMethod {
        switch self {
        case .search(_):
            return .GET
        case .books:
            return .GET
        }
    }

    var requestBody:Data? {
        switch self {
        case .search(_):
            return nil
        case .books:
            return nil
        }
    }

    var endPoint:String {
        switch self {
        case .search(let searchQuery):
            return "/books?"//.appending(searchQuery.getURLQuery())
        case .books:
            return "/books"
        }
    }
}
