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
    
    private let booksRepository: BooksRepositoryProtocol
    
    private(set) var searchSubject = CurrentValueSubject<String, Never>("")
    
    private var subCancellables: Set<AnyCancellable> = []
    
    init(booksRepository: BooksRepositoryProtocol) {
        self.booksRepository = booksRepository
        setupSearchPub()
    }
    
    private func setupSearchPub() {
        searchSubject
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .sink { [weak self] searchQuery in
                self?.executeSearchBooks(query: searchQuery)
            }.store(in: &subCancellables)
    }
    
    func searchBooks(query:String) {
        searchSubject.send(query)
    }
    
    func refreshBooks() async {
        let fetchedBooks = try? await self.booksRepository.refreshBooks()
        await MainActor.run {
            self.state = .loaded
            self.booksDataSource = fetchedBooks ?? []
        }
    }
    
    private func executeSearchBooks(query:String) {
        if query.isEmpty {
            fetchAllBooks()
        } else {
            fetchBooks(searchQuery: query)
        }
    }
    
    private func fetchBooks(searchQuery: String) {
        self.state = .loading
        Task {
            let fetchedBooks = try? await self.booksRepository.searchBooks(query: searchQuery)
            await MainActor.run {
                self.state = .loaded
                self.booksDataSource = fetchedBooks ?? []
            }
        }
    }
    
    private func fetchAllBooks() {
        self.state = .loading
        Task {
            let fetchedBooks = try? await self.booksRepository.fetchBooks()
            await MainActor.run {
                self.state = .loaded
                self.booksDataSource = fetchedBooks ?? []
            }
        }
    }
}
