//
//  ReadifyTests.swift
//  ReadifyTests
//
//  Created by Shakeel Mohamed on 2020-12-20.
//

import XCTest
@testable import Readify

class ReadifyTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testReadingBooksFromGoogle() {
        
        let book = Book()
        var bookData;
        
        book.getBookByIsbn(isbn: "9781782434757", completionHandler: {
            result in
            bookData = result
        })
    }

}
