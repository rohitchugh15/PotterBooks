//
//  BooksRepositoryProtocol.swift
//  PotterBooks
//
//  Created by Rohit Chugh on 25/10/25.
//

import Foundation

protocol BooksRepositoryProtocol {
    
    func fetchBooks() async throws -> [BooksListItem]
    
//    func fetchBooks(searchQuery: String) async throws -> [BooksListItem]
}
