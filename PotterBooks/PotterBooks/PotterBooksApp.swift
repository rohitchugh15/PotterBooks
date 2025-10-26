//
//  PotterBooksApp.swift
//  PotterBooks
//
//  Created by Rohit Chugh on 25/10/25.
//

import SwiftUI
import CoreData

@main
struct PotterBooksApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            HomeView(viewModel: HomeViewModel(booksRepository: LocalBooksRepository(remoteBooksRepository: RemoteBooksRepository())))
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
