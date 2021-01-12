//
//  AddBooksViewController.swift
//  Readify
//
//  Created by Alfred Edwin on 2020-12-26.
//

import UIKit

class AddBooksViewController: UIViewController {
    
    let book: ReadifyBook = ReadifyBook()
    
    var bookItem: ReadifyBook.Item?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textFieldIsbn.delegate = self
        textFieldTitle.delegate = self

        
//        // Do any additional setup after loading the view.
//        let book: ReadifyBook = ReadifyBook()
//
//        var googleResponse: ReadifyBook.GoogleResponse;
//
//
    }
    

    @IBOutlet weak var textFieldIsbn: UITextField!
    @IBOutlet weak var textFieldTitle: UITextField!
    @IBOutlet weak var textFieldAuthor: UITextField!
    @IBOutlet weak var textFieldPublisher: UITextField!
    @IBOutlet weak var textFieldPublishedYear: UITextField!
    
    
    @IBOutlet weak var imageViewThumbnail: UIImageView!
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
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
            
            let data = [
                "title": result.items?[0].volumeInfo.title ?? "",
                "author": authors ?? "",
                "publisher": result.items?[0].volumeInfo.publisher ?? "",
                "publishedDate": result.items?[0].volumeInfo.publishedDate ?? "",
                "thumbnail": thumbnail
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
    
    private func updateUI(_ data: [String:String]) -> Void {
        textFieldTitle.text = data["title"]
        textFieldAuthor.text = data["author"]
        textFieldPublisher.text = data["publisher"]
        textFieldPublishedYear.text = data["publishedDate"]
        
        imageViewThumbnail.image = UIImage()
        
        // load the image from the remote url
        guard let thumbUrl = data["thumbnail"] else { return }
        
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
