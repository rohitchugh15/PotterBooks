//
//  BooksListItem.swift
//  PotterBooks
//
//  Created by Rohit Chugh on 25/10/25.
//

import Foundation

//MARK: Domain Model BooksListItem
struct BooksListItem: Identifiable {
    
    var id:Int64 {
        number
    }
    
    var number: Int64
    let index: Int32
    let title: String
    var originalTitle: String?
    var bookDescription: String?
    var pages: Int32?
    var cover: URL?
    var releaseDate: Date?
}

//MARK: Book DTO
extension BookDTO {
    
    func toDomain() -> BooksListItem {
        return BooksListItem(number: self.number,
                             index: self.index,
                             title: self.title,
                             originalTitle: self.originalTitle,
                             bookDescription: self.bookDescription,
                             pages: self.pages,
                             cover: self.cover,
                             releaseDate: self.releaseDate
        )
    }
}

//MARK: Book CoreData Entity
extension BookEntity {
    
    func toDomain() -> BooksListItem {
        return BooksListItem(number: self.number,
                             index: self.index,
                             title: self.title ?? "na",
                             originalTitle: self.originalTitle,
                             bookDescription: self.bookDescription,
                             pages: self.pages,
                             cover: self.cover,
                             releaseDate: self.releaseDate
        )
    }
}
