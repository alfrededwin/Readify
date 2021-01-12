//
//  ReadifyBook.swift
//  Readify
//
//  Created by Shakeel Mohamed on 2021-01-02.
//

import Foundation

class ReadifyBook {

    // MARK: - Response
    struct GoogleResponse: Codable {
        let kind: String
        let totalItems: Int
        let items: [Item]?
    }

    // MARK: - Item
    struct Item: Codable {
        let kind, id, etag: String
        let selfLink: String
        let volumeInfo: VolumeInfo
        let saleInfo: SaleInfo
        let accessInfo: AccessInfo
        let searchInfo: SearchInfo
    }

    // MARK: - AccessInfo
    struct AccessInfo: Codable {
        let country, viewability: String
        let embeddable, publicDomain: Bool
        let textToSpeechPermission: String
        let epub, pdf: Epub
        let webReaderLink: String
        let accessViewStatus: String
        let quoteSharingAllowed: Bool
    }

    // MARK: - Epub
    struct Epub: Codable {
        let isAvailable: Bool
    }

    // MARK: - SaleInfo
    struct SaleInfo: Codable {
        let country, saleability: String
        let isEbook: Bool
    }

    // MARK: - SearchInfo
    struct SearchInfo: Codable {
        let textSnippet: String
    }

    // MARK: - VolumeInfo
    struct VolumeInfo: Codable {
        let title: String
        let authors: [String]
        let publisher, publishedDate, volumeInfoDescription: String
        let industryIdentifiers: [IndustryIdentifier]
        let readingModes: ReadingModes
        let pageCount: Int
        let printType, maturityRating: String
        let allowAnonLogging: Bool
        let contentVersion: String
        let panelizationSummary: PanelizationSummary
        let imageLinks: ImageLinks?
        let language: String
        let previewLink, infoLink: String
        let canonicalVolumeLink: String

        enum CodingKeys: String, CodingKey {
            case title, authors, publisher, publishedDate
            case volumeInfoDescription = "description"
            case industryIdentifiers, readingModes, pageCount, printType, maturityRating, allowAnonLogging, contentVersion, panelizationSummary, imageLinks, language, previewLink, infoLink, canonicalVolumeLink
        }
    }

    // MARK: - ImageLinks
    struct ImageLinks: Codable {
        let smallThumbnail, thumbnail: String
    }

    // MARK: - IndustryIdentifier
    struct IndustryIdentifier: Codable {
        let type, identifier: String
    }

    // MARK: - PanelizationSummary
    struct PanelizationSummary: Codable {
        let containsEpubBubbles, containsImageBubbles: Bool
    }

    // MARK: - ReadingModes
    struct ReadingModes: Codable {
        let text, image: Bool
    }


    func getBookByIsbn(isbn: String, completionHandler:@escaping (GoogleResponse) -> Void) {
        
        var baseUrl: String;
        var apiKey: String;
        
        if let config = ApiHelper.getConfig() {
            baseUrl = config.baseUrl
            apiKey = config.googleBooksApiKey
        } else {
            return
        }
        
        let url = "\(baseUrl)=isbn:\(isbn)&key=\(apiKey)"
        
        ApiHelper.getData(with: url, completion: {
            response in
            completionHandler(response)
        })
    }
    
    
    func validateIsbn(_ isbn: String) -> (valid: Bool, error: String) {
        // isbn length is 10 or 13
        if (isbn.count > 10 && isbn.count < 13 || isbn.count < 10) {
            return (valid: false, error: "Invalid ISBN number")
        }
        
        // isbn should contain only numbers
        let regexNumbersOnly = try! NSRegularExpression(pattern: ".*[^0-9].*", options: [])
        let isbnNumberCheck = regexNumbersOnly.firstMatch(in: isbn, options: [], range: NSMakeRange(0, isbn.count)) == nil
        if (!isbnNumberCheck) {
            return (valid: false, error: "Invalid ISBN number")
        }
        
        return (valid: true, error: "")
    }
}

