//
//  LocalBooksRepository.swift
//  PotterBooks
//
//  Created by Rohit Chugh on 25/10/25.
//

import Foundation
import CoreData

final class LocalBooksRepository: BooksRepositoryProtocol {
    
    private let context = PersistenceController.shared.container.viewContext
    
    func fetchBooks() async throws -> [BooksListItem] {
        // 1: Load from local
        do {
            let localBooks = try fetchBooksFromCoreData()
            if !localBooks.isEmpty {
                return localBooks.map({$0.toDomain()})
            }
        } catch {
            print("Local fetch error: \(error)")
        }
        
        // Step 2: Fetch from remote & update local
        do {
            let remoteBooks = try await RemoteBooksRepository().fetchBooks()
            try saveBooks(remoteBooks)
            return remoteBooks
        } catch {
            throw error
        }
    }
    
    func fetchBooksFromCoreData() throws -> [BookEntity] {
        let request = BookEntity.fetchRequest()
        let entities = try context.fetch(request)
        return entities
    }
    
    func saveBooks(_ books: [BooksListItem]) throws {
        for book in books {
            let request = BookEntity.fetchRequest()
            request.predicate = NSPredicate(format: "number == %d", book.number)
            let existing = try context.fetch(request).first ?? BookEntity(context: context)
            existing.number = book.number
            existing.index = book.index
            existing.title = book.title
            existing.bookDescription = book.bookDescription
            existing.cover = book.cover
            existing.releaseDate = book.releaseDate
            existing.pages = book.pages ?? 0
        }
        try context.save()
    }
}
