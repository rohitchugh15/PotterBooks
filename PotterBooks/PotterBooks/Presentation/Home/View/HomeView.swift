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
            .overlay(alignment: .top) {
                switch viewModel.state {
                case .loading:
                    ProgressView("Loading...")
                case .error(let errorMessage):
                    Text(errorMessage)
                        .padding(4)
                        .background(Color.red.opacity(0.9))
                        .cornerRadius(4)
                case .loaded:
                    if viewModel.booksDataSource.isEmpty {
                        Text("No books found")
                            .padding(4)
                            .background(Color.red.opacity(0.9))
                            .cornerRadius(4)
                    }
                case .offline:
                    Text("No internet connection")
                        .padding(4)
                        .background(Color.red.opacity(0.9))
                        .cornerRadius(4)
                }
            }
            .searchable(text: $searchQuery)
            .onChange(of: searchQuery) {
                self.viewModel.searchBooks(query: searchQuery)
            }
            .refreshable {
                await self.viewModel.refreshBooks()
            }
            .navigationTitle("Potter Books")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    if viewModel.isOnline {
                        Image(systemName: "wifi")
                            .foregroundStyle(Color.green.gradient)
                    } else {
                        Image(systemName: "wifi.slash")
                            .foregroundStyle(Color.red.gradient)
                    }
                }
            }
            
        }
    }
}

#Preview {
    HomeView(viewModel: HomeViewModel(booksRepository: MockBooksRepository()))
}
