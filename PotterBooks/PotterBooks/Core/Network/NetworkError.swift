//
//  NetworkError.swift
//  PotterBooks
//
//  Created by Rohit Chugh on 25/10/25.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case offline
    case transport(Error)
    case server(status: Int, body: Data?)
    case decoding(Error)
}
