//
//  Book+CoreDataProperties.swift
//  Readify
//
//  Created by Shakeel Mohamed on 2020-12-28.
//
//

import Foundation
import CoreData


extension Book {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Book> {
        return NSFetchRequest<Book>(entityName: "Book")
    }

    @NSManaged public var created_at: Date?
    @NSManaged public var isbn_10: Int16
    @NSManaged public var isbn_13: Int16
    @NSManaged public var language: String?
    @NSManaged public var page_count: Int16
    @NSManaged public var published_date: Date?
    @NSManaged public var publisher: String?
    @NSManaged public var short_description: String?
    @NSManaged public var title: String?
    @NSManaged public var booklist: BookList?

}

extension Book : Identifiable {

}
