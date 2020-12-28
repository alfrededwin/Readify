//
//  BookList+CoreDataProperties.swift
//  Readify
//
//  Created by Shakeel Mohamed on 2020-12-28.
//
//

import Foundation
import CoreData


extension BookList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BookList> {
        return NSFetchRequest<BookList>(entityName: "BookList")
    }

    @NSManaged public var list_type: Int16
    @NSManaged public var updated_at: Date?
    @NSManaged public var books: NSSet?

}

// MARK: Generated accessors for books
extension BookList {

    @objc(addBooksObject:)
    @NSManaged public func addToBooks(_ value: Book)

    @objc(removeBooksObject:)
    @NSManaged public func removeFromBooks(_ value: Book)

    @objc(addBooks:)
    @NSManaged public func addToBooks(_ values: NSSet)

    @objc(removeBooks:)
    @NSManaged public func removeFromBooks(_ values: NSSet)

}

extension BookList : Identifiable {

}
