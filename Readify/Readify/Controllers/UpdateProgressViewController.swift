//
//  UpdateProgressViewController.swift
//  Readify
//
//  Created by Adam Ameen on 2021-01-15.
//

import UIKit
import CoreData

class UpdateProgressViewController: UIViewController {

    var book: Book!
    var context: NSManagedObjectContext!
    
    @IBOutlet weak var txtNumberOfPages: UITextField!
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var bookTotalPages: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bookTitle.text = book.title
        bookTotalPages.text = "Total pages: " + String(book.page_count)
        txtNumberOfPages.text = String(book.current_page)
        
    }
    
    
    @IBAction func cancelModal(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func saveProgress(_ sender: Any) {
        if (txtNumberOfPages.text == ""){
            
            showAlert(title: "No data to save", message: "Enter the number of pages you have read")
            
        } else {
            
            let readPage: Int16 = Int16(txtNumberOfPages.text!) ?? 0
            
            if (readPage > book.page_count) {
                showAlert(title: "Incorrect page number", message: "This book has only \(book.page_count) pages")
                
                return
            }
            
            book.current_page = Int16(readPage)
            
            do {
                // save the value
                try self.context?.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
            
            showAlert(title: "Updated successfully", message: "")
            
        }
    }
    
    @IBAction func markBookComplete(_ sender: Any) {

        
        // create the list, default to whish list
        let bookList = BookList.init(context: self.context)
        
        bookList.name = "Completed List"
        bookList.list_type = 2
        bookList.addToBooks(book)
        
        do {
            // save the value
            try self.context?.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        showAlert(title: "Added to completed list", message: "")
        
    }
    
    private func showAlert(title: String, message: String) -> Void {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }

}

extension UpdateProgressViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
