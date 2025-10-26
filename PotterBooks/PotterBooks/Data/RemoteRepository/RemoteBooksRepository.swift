//
//  RemoteBooksRepository.swift
//  PotterBooks
//
//  Created by Rohit Chugh on 25/10/25.
//

import Foundation

final class RemoteBooksRepository: BooksRepositoryProtocol {
    
    func searchBooks(query: String) async throws -> [BooksListItem] {
        return []
    }
    
    func fetchBooks() async throws -> [BooksListItem] {
        let fetchBooksURLRequest = BookRequestBuilder.books.urlRequest()
        
        do {
            let decoder = JSONDecoder()
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM dd, yyyy"
            decoder.dateDecodingStrategy = .formatted(dateFormatter)
            
            let booksDTO: [BookDTO] = try await RequestHandler(decoder: decoder).sendRequest(fetchBooksURLRequest, as: [BookDTO].self)
            return booksDTO.map({$0.toDomain()})
        } catch {
            throw error
        }
    }
}
