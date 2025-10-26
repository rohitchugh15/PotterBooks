//
//  Request.swift
//  PotterBooks
//
//  Created by Rohit Chugh on 25/10/25.
//

import Foundation

struct RequestHandler {
    
    private let session: URLSession
    private let decoder: JSONDecoder
    
    init(session: URLSession = .shared, decoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        self.decoder = decoder
    }
    
    func sendRequest<T: Decodable>(_ request: URLRequest, as type: T.Type) async throws -> T {
        let (data, response) = try await session.data(for: request)
        
        try validate(response: response, data: data)
        
        return try decode(data, as: T.self)
    }
    
    private func validate(response: URLResponse, data: Data) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.server(httpResponse.statusCode)
        }
    }
    
    private func decode<T: Decodable>(_ data: Data, as type: T.Type) throws -> T {
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NetworkError.decoding(error)
        }
    }
}

