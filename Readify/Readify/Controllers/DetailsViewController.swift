//
//  DetailsViewController.swift
//  Readify
//
//  Created by Adam Ameen on 2021-01-15.
//

import UIKit
import CoreData

class DetailsViewController: UIViewController {

    
    var book: Book!
    var context: NSManagedObjectContext!
    var listMode: Int!
    
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var bookAuthor: UILabel!
    @IBOutlet weak var bookDescription: UILabel!
    @IBOutlet weak var bookPublisher: UILabel!
    @IBOutlet weak var bookIsbn: UILabel!
    @IBOutlet weak var bookPublishedYear: UILabel!
    @IBOutlet weak var bookPageCount: UILabel!
    
    
    @IBOutlet weak var wishListButton: UIButton!
    @IBOutlet weak var readingListButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let image = book.image {
            bookImage.image = UIImage(data: image)
        }
        
        bookTitle.text = book.title
        bookAuthor.text = book.author
        bookDescription.text = book.short_description
        bookPublisher.text = "Publisher: " + (book?.publisher)!
        
        if let publishedDate = book.published_date {
            bookPublishedYear.text = "Published in: " + publishedDate
        } else {
            bookPublishedYear.text = "Published in: N/A"
        }

        bookIsbn.text = (book.isbn_10!) + "/" + (book.isbn_13!)
        bookPageCount.text = String(book.page_count ) + " pages"
        
        // set the buttons
        switch listMode {
        case 0:
            // coming from reading list
            readingListButton.isHidden = true
            wishListButton.isHidden = false
            
        case 1:
            //coming from completed list
            readingListButton.isHidden = false
            wishListButton.isHidden = true
            
        default:
            //coming from wish list
            readingListButton.isHidden = false
            wishListButton.isHidden = true
        }
        
    }
    

    @IBAction func addToReading(_ sender: Any) {
        // create the list
        let bookList = BookList.init(context: self.context)
        
        bookList.name = "Reading List"
        bookList.list_type = 1
        bookList.addToBooks(book)
        
        book.reading_started_at = Date()
        
        do {
            // save the value
            try self.context?.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        showAlert(title: "Added to reading list", message: "")
    }
    
    
    @IBAction func addToWishList(_ sender: Any) {
        let bookList = BookList.init(context: self.context)
        
        bookList.name = "Wish List"
        bookList.list_type = 1
        bookList.addToBooks(book)
        
        do {
            // save the value
            try self.context?.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        showAlert(title: "Added to wish list", message: "")
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch (segue.identifier ?? "") {
        case "updateProgress":
            
            let destination = segue.destination as! UINavigationController
            let updateProgressVc = destination.topViewController as! UpdateProgressViewController
            
            updateProgressVc.book = book
            updateProgressVc.context = context
            
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
            
        }
    }
    

    private func showAlert(title: String, message: String) -> Void {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
}
