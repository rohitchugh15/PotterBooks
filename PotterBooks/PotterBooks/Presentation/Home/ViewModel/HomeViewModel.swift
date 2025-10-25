//
//  HomeViewModel.swift
//  PotterBooks
//
//  Created by Rohit Chugh on 25/10/25.
//

import Foundation
import Combine

enum MovieSearchViewModelState {
    case empty
    case offline
    case loading
    case loaded
    case error(String)
}

class HomeViewModel: ObservableObject {
    
    @Published private(set) var state: MovieSearchViewModelState = .empty
    
    @Published private(set) var booksDataSource: [BooksListItem] = []
    
    private var allBooks: [BooksListItem] = []
    
    private let booksRepository: BooksRepositoryProtocol
    
    init(booksRepository: BooksRepositoryProtocol) {
        self.booksRepository = booksRepository
    }
    
    func fetchAllBooks() {
        if self.allBooks.isEmpty {
            self.state = .loading
            Task {
                let fetchedBooks = try? await self.booksRepository.fetchBooks()
                self.allBooks = fetchedBooks ?? []
                await MainActor.run {
                    self.state = .loaded
                    self.booksDataSource = self.allBooks
                }
            }
        } else {
            self.state = .loaded
            self.booksDataSource = self.allBooks
        }
    }
}
