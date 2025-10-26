//
//  HomeView.swift
//  PotterBooks
//
//  Created by Rohit Chugh on 25/10/25.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel: HomeViewModel
    
    @State private var searchQuery: String = ""
    
    var body: some View {
        NavigationStack {
            List(viewModel.booksDataSource) { book in
                HStack {
                    AsyncImage(url: book.cover) { phase in
                        switch phase {
                        case .empty, .failure:
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                                .cornerRadius(40)
                        case .success(let image):
                            image.resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 80, height: 80)
                                .cornerRadius(40)
                        default:
                            ProgressView()
                        }
                    }
                    
                    VStack(alignment: .leading) {
                        Text(book.title).bold()
                        Text("Released: \(book.releasedYear ?? "-")")
                            .font(.subheadline)
                    }
                }
            }
            .listStyle(.plain)
            .overlay(content: {
                switch viewModel.state {
                case .loading:
                    ProgressView("Loading...")
                case .error(let errorMessage):
                    Text(errorMessage)
                case .empty:
                    Text("Please search by book title")
                case .loaded:
                    if viewModel.booksDataSource.isEmpty {
                        Text("No book found")
                    }
                case .offline:
                    Text("Please check your internet connection")
                }
            })
            .searchable(text: $searchQuery)
            .onChange(of: searchQuery) {
                self.viewModel.searchBooks(query: searchQuery)
            }
        }
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel(booksRepository: RemoteBooksRepository()))
}
