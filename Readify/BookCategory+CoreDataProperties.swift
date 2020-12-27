//
//  BookCategory+CoreDataProperties.swift
//  Readify
//
//  Created by Shakeel Mohamed on 2020-12-28.
//
//

import Foundation
import CoreData


extension BookCategory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BookCategory> {
        return NSFetchRequest<BookCategory>(entityName: "BookCategory")
    }

    @NSManaged public var name: String?
    @NSManaged public var books: NSSet?

}

// MARK: Generated accessors for books
extension BookCategory {

    @objc(addBooksObject:)
    @NSManaged public func addToBooks(_ value: Book)

    @objc(removeBooksObject:)
    @NSManaged public func removeFromBooks(_ value: Book)

    @objc(addBooks:)
    @NSManaged public func addToBooks(_ values: NSSet)

    @objc(removeBooks:)
    @NSManaged public func removeFromBooks(_ values: NSSet)

}

extension BookCategory : Identifiable {

}
