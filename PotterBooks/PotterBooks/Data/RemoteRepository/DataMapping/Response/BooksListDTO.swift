//
//  BooksListDTO.swift
//  PotterBooks
//
//  Created by Rohit Chugh on 25/10/25.
//

import Foundation

//MARK: BookDTO
struct BookDTO: Decodable {
    
    let number: Int64
    let index:Int32
    let title: String
    var bookDescription: String?
    var releaseDate: Date?
    var originalTitle: String?
    var pages: Int32?
    var cover: URL?
    
    enum CodingKeys: String, CodingKey {
        case index
        case number
        case title
        case bookDescription = "description"
        case releaseDate
        case originalTitle
        case pages
        case cover
    }
}
