//
//  MockBooksRepository.swift
//  PotterBooks
//
//  Created by Rohit Chugh on 26/10/25.
//

import Foundation

class MockBooksRepository: BooksRepositoryProtocol {
    
    func fetchBooks() async throws -> [BooksListItem] {
        guard let jsonData = Bundle(for: Self.self).dataFromJson(fileName: "BooksMockResponse") else {
            throw NetworkError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM dd, yyyy"
            decoder.dateDecodingStrategy = .formatted(dateFormatter)
            
            let booksDTO = try decoder.decode([BookDTO].self, from: jsonData)
            return booksDTO.map({$0.toDomain()})
        } catch {
            throw NetworkError.decoding(error)
        }
    }
}
