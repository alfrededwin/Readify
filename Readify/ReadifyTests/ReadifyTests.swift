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
        
        let book = ReadifyBook()
        
        book.getBookByIsbn(isbn: "9781782434757", completionHandler: {
            result in
            
            XCTAssertEqual("Sudoku 1", result.items?[0].volumeInfo.title)
        })
        
    }
    
    func testReadingBooksFromGoogle2() {
        
        let book = ReadifyBook()
        
        book.getBookByIsbn(isbn: "9780316015844", completionHandler: {
            result in
            
            XCTAssertEqual("Twilight", result.items?[0].volumeInfo.title)
        })
        
    }
    
    func testIsbnValidation() {
        let book = ReadifyBook();
        
        // isban cant be less than 10 digit
        let response1: (valid:Bool, error:String) = book.validateIsbn("12345")
        XCTAssertEqual(response1.valid, false)
        
        // isbn can't be less than 13 digit if it is more than 10
        let response2: (valid:Bool, error:String) = book.validateIsbn("12345678901")
        XCTAssertEqual(response2.valid, false)
        
        // isbn can be only numbers
        let response3: (valid:Bool, error:String) = book.validateIsbn("abc1234567")
        XCTAssertEqual(response3.valid, false)
        
        // isbn with 10 digits should pass
        let response4: (valid:Bool, error:String) = book.validateIsbn("9781782434")
        XCTAssertEqual(response4.valid, true)
        
        // isbn with 13 digits should pass
        let response5: (valid:Bool, error:String) = book.validateIsbn("9781782434757")
        XCTAssertEqual(response5.valid, true)
        
    }

}
