//
//  BooksListItem.swift
//  PotterBooks
//
//  Created by Rohit Chugh on 25/10/25.
//

import Foundation

struct BooksListItem: Identifiable {
    
    var id:Int {
        number
    }
    
    var number: Int
    let index: Int
    let title: String
    var bookDescription: String?
    var releaseYear: String?
    var pages: Int?
    var cover: URL?
}

extension BookDTO {
    
    func toDomain() -> BooksListItem {
        return BooksListItem(number: self.number,
                             index: self.index,
                             title: self.title,
                             bookDescription: self.bookDescription,
                             releaseYear: self.releaseDate?.toString(formatter: "yyyy"),
                             pages: self.pages,
                             cover: self.cover
        )
    }
}
