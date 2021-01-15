//
//  DetailsViewController.swift
//  Readify
//
//  Created by Adam Ameen on 2021-01-15.
//

import UIKit

class DetailsViewController: UIViewController {

    
    var book: Book?
    
    
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var bookAuthor: UILabel!
    @IBOutlet weak var bookDescription: UILabel!
    @IBOutlet weak var bookPublisher: UILabel!
    @IBOutlet weak var bookIsbn: UILabel!
    @IBOutlet weak var bookPublishedYear: UILabel!
    @IBOutlet weak var bookPageCount: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let image = book?.image {
            bookImage.image = UIImage(data: image)
        }
        
        bookTitle.text = book?.title
        bookAuthor.text = book?.author
        bookDescription.text = book?.short_description
        bookPublisher.text = "Publisher: " + (book?.publisher)!
        
        if let publishedDate = book?.published_date {
            bookPublishedYear.text = "Published in: " + publishedDate
        } else {
            bookPublishedYear.text = "Published in: N/A"
        }

        bookIsbn.text = (book?.isbn_10!)! + "/" + (book?.isbn_13!)!
        bookPageCount.text = String(book?.page_count ?? 0) + " pages"
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
