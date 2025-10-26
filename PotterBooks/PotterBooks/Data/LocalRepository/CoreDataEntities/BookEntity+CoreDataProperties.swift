//
//  BookEntity+CoreDataProperties.swift
//  PotterBooks
//
//  Created by Rohit Chugh on 26/10/25.
//
//

public import Foundation
public import CoreData


public typealias BookEntityCoreDataPropertiesSet = NSSet

extension BookEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BookEntity> {
        return NSFetchRequest<BookEntity>(entityName: "BookEntity")
    }

    @NSManaged public var number: Int64
    @NSManaged public var title: String?
    @NSManaged public var releaseDate: Date?
    @NSManaged public var bookDescription: String?
    @NSManaged public var pages: Int32
    @NSManaged public var cover: URL?
    @NSManaged public var index: Int32
    @NSManaged public var originalTitle: String?

}

extension BookEntity : Identifiable {

}
