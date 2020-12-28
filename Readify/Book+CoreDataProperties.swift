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
    @NSManaged public var current_page: Int16
    @NSManaged public var booklist: BookList?
    @NSManaged public var authors: NSSet?
    @NSManaged public var categories: BookCategory?
    @NSManaged public var activities: NSSet?

}

// MARK: Generated accessors for authors
extension Book {

    @objc(addAuthorsObject:)
    @NSManaged public func addToAuthors(_ value: Author)

    @objc(removeAuthorsObject:)
    @NSManaged public func removeFromAuthors(_ value: Author)

    @objc(addAuthors:)
    @NSManaged public func addToAuthors(_ values: NSSet)

    @objc(removeAuthors:)
    @NSManaged public func removeFromAuthors(_ values: NSSet)

}

// MARK: Generated accessors for activities
extension Book {

    @objc(addActivitiesObject:)
    @NSManaged public func addToActivities(_ value: BookActivity)

    @objc(removeActivitiesObject:)
    @NSManaged public func removeFromActivities(_ value: BookActivity)

    @objc(addActivities:)
    @NSManaged public func addToActivities(_ values: NSSet)

    @objc(removeActivities:)
    @NSManaged public func removeFromActivities(_ values: NSSet)

}

extension Book : Identifiable {

}
