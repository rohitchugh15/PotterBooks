//
//  BooksRepositoryProtocol.swift
//  PotterBooks
//
//  Created by Rohit Chugh on 25/10/25.
//

import Foundation

protocol BooksRepositoryProtocol {
    
    func fetchBooks() async throws -> [BooksListItem]
    
    func searchBooks(query: String) async throws -> [BooksListItem]
    
    func refreshBooks() async throws -> [BooksListItem]
}
