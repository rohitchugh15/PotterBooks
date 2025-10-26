# PotterBooks
PotterBooks is an iOS application that displays a collection of Harry Potter books. It demonstrates modern SwiftUI development, clean MVVM architecture, local persistence with Core Data, remote API synchronization, and offline/online support.

PotterBooks/
├── App/
│   └── PotterBooksApp.swift         # App entry point
├── Models/
│   └── BooksListItem.swift          # Domain model
│   └── BookDTO.swift                # Decodable Remote Data Model
│   └── BookEntity.swift             # NSManagedObject Core data entity model
├── CoreData/
│   └── BookEntity.xcdatamodeld      # Core Data entity
├── Repositories/
│   ├── LocalBookRepository.swift    # Handles Core Data
│   └── RemoteBookRepository.swift   # Handles API calls
├── Network/
│   └── RequestHandler.swift         # URL request call async await
│   └── URLRequestBuilder.swift      # URL Request builder
│   └── NetworkMonitor.swift         # Connectivity monitoring
├── ViewModels/
│   └── HomeViewModel.swift         # Business logic & state management
├── Views/
│   ├── HomeView.swift              # List of books
└── Core/
    └── Constants                   # URLConstants
    └── Extensions                  # BundleExtension, DateExtension & EncodableExtension
    
Core Concepts
* Repository Pattern:
    * LocalBookRepository – fetches and stores books in Core Data.
    * RemoteBookRepository – fetches books from API (https://potterapi-fedeperin.vercel.app/en/books) and updates local storage.
    * ViewModel depends on a single repository but can switch between local/remote easily.
* MVVM:
    * ViewModel handles state management (loading, loaded, offline, error) and data transformations.
    * View is reactive and reflects @Published properties from the ViewModel.
* Offline & Online Support:
    * NetworkMonitor tracks connectivity.
    * Offline mode loads local Core Data while showing indicator for connectivity.
* Core Data:
    * BookEntity mirrors the BooksListItem domain model.
    * Local repository performs fetch from remote & save locally 
    * Supports search via predicates on title and description.
* Swift Concurrency:
    * Uses async/await for network and persistence operations.
* Features:
    * Search directly from Core Data
    * Pull-to-refresh
    * Online/offline indicator in the navigation bar
    
⚙️ Setup Instructions
Prerequisites
* Xcode 14+
* Swift 5.9+
Steps
1. Clone the repository:
git clone https://github.com/rohitchugh15/PotterBooks.git
2 Open the project in Xcode:
open PotterBooks.xcodeproj
1. Build and run the app on a simulator or device.
2. The app automatically fetches books from then API for first time and saves to local storage

📱 Screenshots
List of books with poster, title, release year, and rating.
Simulator Screenshot - iPhone 17 - 2025-10-27 at 01.34.56.png
Simulator Screenshot - iPhone 17 - 2025-10-27 at 01.34.47.png
