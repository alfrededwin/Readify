//
//  AddBooksViewController.swift
//  Readify
//
//  Created by Alfred Edwin on 2020-12-26.
//

import UIKit
import CoreData

class AddBooksViewController: UIViewController {
    
    var book: ReadifyBook!
    
    var bookItem: ReadifyBook.Item?
    
    var bookData = [String: Any]()
    var context: NSManagedObjectContext!
    
    @IBOutlet weak var textFieldIsbn: UITextField!
    @IBOutlet weak var textFieldTitle: UITextField!
    @IBOutlet weak var textFieldAuthor: UITextField!
    @IBOutlet weak var textFieldPublisher: UITextField!
    @IBOutlet weak var textFieldPublishedYear: UITextField!
    
    
    @IBOutlet weak var imageViewThumbnail: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        book = ReadifyBook()
        
        textFieldIsbn.delegate = self
        textFieldTitle.delegate = self

    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print(segue.identifier ?? "")
    }
    
    
    
    @IBAction func AddNewBook(_ sender: UIBarButtonItem) {
        if bookData.isEmpty {
            showAlert(title: "No data to save", message: "Enter an ISBN to search book")
            return
        }
        
        saveBook(bookData)
        
        showAlert(title: "Book saved", message: "Book saved to wish list")
    }
    
    private func getBookDetailsFromApi(isbn: String) -> Void {
        book.getBookByIsbn(isbn: isbn, completionHandler: {
            result in
            
            if result.totalItems == 0 {
                DispatchQueue.main.async {
                    self.clearUI();
                }
                return
            }
            
            
            let authors = result.items?[0].volumeInfo.authors.joined(separator: ", ")
            var thumbnail: String = ""
            
            if let imageLinks = result.items?[0].volumeInfo.imageLinks?.thumbnail {
                thumbnail = imageLinks
            } else {
                print("Image link not available")
            }
            
            var isbn10: String = ""
            var isbn13: String = ""
            if let indIdnety = result.items?[0].volumeInfo.industryIdentifiers {
                
                for val in indIdnety {
                    if val.type == "ISBN_10" {
                        isbn10 = val.identifier
                    } else {
                        isbn13 = val.identifier
                    }
                }
                
            }
            
            
            let data: [String: Any] = [
                "title": result.items?[0].volumeInfo.title ?? "",
                "author": authors ?? "",
                "publisher": result.items?[0].volumeInfo.publisher ?? "",
                "publishedDate": result.items?[0].volumeInfo.publishedDate ?? "",
                "thumbnail": thumbnail,
                "isbn10": isbn10,
                "isbn13": isbn13,
                "currentPage": Int16(0),
                "language": result.items?[0].volumeInfo.language ?? "",
                "shortDesc": result.items?[0].volumeInfo.volumeInfoDescription ?? "",
                "pageCount": Int16(result.items?[0].volumeInfo.pageCount ?? 0)
            ]
            
            
            // pass the data to the main thread
            DispatchQueue.main.async {
                self.updateUI(data)
            }
        })
    }
    
    private func clearUI() {
        textFieldTitle.text = ""
        textFieldAuthor.text = ""
        textFieldPublisher.text = ""
        textFieldPublishedYear.text = ""
        
        imageViewThumbnail.image = UIImage()
        
        showAlert(title: "Book not found", message: "No data found for the ISBN provided")
    }
    
    private func updateUI(_ data: [String: Any]) -> Void {
        // update temp dic data
        bookData = data
        
        textFieldTitle.text = data["title"] as? String
        textFieldAuthor.text = data["author"] as? String
        textFieldPublisher.text = data["publisher"] as? String
        textFieldPublishedYear.text = data["publishedDate"] as? String
        
        imageViewThumbnail.image = UIImage()
        
        // load the image from the remote url
        guard let thumbUrl = data["thumbnail"] as? String else { return }
        
        ApiHelper.loadRemoteImage(with: thumbUrl, completionHandler: {
            imageData in
            
            guard let image = imageData else { return } // don't do anything if there is not data
            DispatchQueue.main.async {
                self.imageViewThumbnail.image = UIImage(data: image)
            }
        })
    }
    
    
    private func showAlert(title: String, message: String) -> Void {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func saveBook(_ data: [String: Any]) -> Void {
        let book = Book.init(context: self.context)
        book.title = data["title"] as! String
        book.publisher = data["publisher"] as! String
        book.published_date = data["publishedDate"] as! String
        book.isbn_10 = data["isbn10"] as! String
        book.isbn_13 = data["isbn13"] as! String
        book.current_page = data["currentPage"] as? Int16 ?? 0
        book.language = data["language"] as! String
        book.page_count = data["pageCount"] as? Int16 ?? 0
        book.short_description = data["shortDesc"] as! String
        book.author = data["author"] as! String
        book.created_at = Date()
        
        if let imageData = imageViewThumbnail.image?.pngData() {
            book.image = imageData
        }
        
        // create the list, default to whish list
        let bookList = BookList.init(context: self.context)
        bookList.name = "Wish List"
        bookList.list_type = 3
        
        bookList.addToBooks(book)
        
        do {
            try self.context?.save()
        } catch let error as NSError {
            print(error)
        }
    }

}

extension AddBooksViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField == textFieldIsbn) {
            
            // get isbn text
            guard let isbnText = textFieldIsbn.text else {
                return false
            }
            
            // validate ISBN
            let isbnValidate = book.validateIsbn(isbnText)
            
            if (!isbnValidate.valid) {
                showAlert(title: "Invalid ISBN", message: isbnValidate.error)
                return false
            }
            
            // ISBN valid. Call Google API and get data
            getBookDetailsFromApi(isbn: textFieldIsbn.text!)
        }
        return true
    }
}
