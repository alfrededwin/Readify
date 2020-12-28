//
//  BookActivity+CoreDataProperties.swift
//  Readify
//
//  Created by Shakeel Mohamed on 2020-12-28.
//
//

import Foundation
import CoreData


extension BookActivity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BookActivity> {
        return NSFetchRequest<BookActivity>(entityName: "BookActivity")
    }

    @NSManaged public var activity_type: Int16
    @NSManaged public var created_at: Date?
    @NSManaged public var book: Book?

}

extension BookActivity : Identifiable {

}
