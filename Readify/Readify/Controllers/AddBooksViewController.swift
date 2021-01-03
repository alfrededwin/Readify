//
//  AddBooksViewController.swift
//  Readify
//
//  Created by Alfred Edwin on 2020-12-26.
//

import UIKit

class AddBooksViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let book: ReadifyBook = ReadifyBook()
        
        var googleResponse: ReadifyBook.GoogleResponse;
        
        book.getBookByIsbn(isbn: "9781782434757", completionHandler: {
            result in
            print(result.items[0].volumeInfo.title)
        })
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
