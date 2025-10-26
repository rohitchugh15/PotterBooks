//
//  MockBooksRepository.swift
//  PotterBooks
//
//  Created by Rohit Chugh on 26/10/25.
//

import Foundation

enum MockBookResponseType: Int {
    case success
    case error
    case offline
}

class MockBooksRepository: BooksRepositoryProtocol {
    
    private(set) var responseType: MockBookResponseType
    
    init(responseType: MockBookResponseType = .success) {
        self.responseType = responseType
    }
    
    func fetchBooks() async throws -> [BooksListItem] {
        switch responseType {
        case .error:
            throw NetworkError.invalidResponse
        case .offline:
            throw NetworkError.offline
        default:
            do {
                guard let jsonData = Bundle(for: Self.self).dataFromJson(fileName: "BooksMockResponse") else { throw NetworkError.invalidResponse }
                
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
    
    func searchBooks(query: String) async throws -> [BooksListItem] {
        return []
    }
    
    func refreshBooks() async throws -> [BooksListItem] {
        do {
            return try await fetchBooks()
        } catch {
            throw error
        }
    }
}
