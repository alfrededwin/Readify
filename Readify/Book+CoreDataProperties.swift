//
//  Book+CoreDataProperties.swift
//  Readify
//
//  Created by Shakeel Mohamed on 2021-01-15.
//
//

import Foundation
import CoreData


extension Book {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Book> {
        return NSFetchRequest<Book>(entityName: "Book")
    }

    @NSManaged public var created_at: Date?
    @NSManaged public var current_page: Int16
    @NSManaged public var image: Data?
    @NSManaged public var isbn_10: String?
    @NSManaged public var isbn_13: String?
    @NSManaged public var language: String?
    @NSManaged public var page_count: Int16
    @NSManaged public var published_date: String?
    @NSManaged public var publisher: String?
    @NSManaged public var short_description: String?
    @NSManaged public var title: String?
    @NSManaged public var author: String?
    @NSManaged public var activities: NSSet?
    @NSManaged public var authors: NSSet?
    @NSManaged public var booklist: BookList?
    @NSManaged public var categories: NSSet?

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

// MARK: Generated accessors for categories
extension Book {

    @objc(addCategoriesObject:)
    @NSManaged public func addToCategories(_ value: BookCategory)

    @objc(removeCategoriesObject:)
    @NSManaged public func removeFromCategories(_ value: BookCategory)

    @objc(addCategories:)
    @NSManaged public func addToCategories(_ values: NSSet)

    @objc(removeCategories:)
    @NSManaged public func removeFromCategories(_ values: NSSet)

}

extension Book : Identifiable {

}
