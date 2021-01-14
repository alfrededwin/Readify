//
//  BooksViewController.swift
//  Readify
//
//  Created by Alfred Edwin on 2020-12-26.
//
// Reference : https://www.youtube.com/watch?v=6GZFXaLId3I
// Ref : https://www.youtube.com/watch?v=dw7kytoA3KU
// https://www.youtube.com/watch?v=kYmZ-4l0Yy4


import UIKit

struct cellData {
    let bookTitle : String!
    let bookAuthor : String!
}


class BooksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //Variables
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableViewControl: UITableView!
    var arrayOfCellDataCompleted = [cellData]()
    var arrayOfCellDataReading = [cellData]()
    var arrayOfCellWishlist = [cellData]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewControl.delegate = self
        tableViewControl.dataSource = self
        
        arrayOfCellDataCompleted = [cellData(bookTitle: "Harry", bookAuthor: "HarryAuthor"),
                                    cellData(bookTitle: "Jone", bookAuthor: "JonesAuthor"),
                                    cellData(bookTitle: "Mark", bookAuthor: "MarksAuthor")]
        
        arrayOfCellDataReading = [cellData(bookTitle: "RdBook1", bookAuthor: "RdBook1Author"),
                                  cellData(bookTitle: "RdBook2", bookAuthor: "RdBook2Author"),
                                  cellData(bookTitle: "RdBook3", bookAuthor: "RdBook3Author"),
                                  cellData(bookTitle: "RdBook4", bookAuthor: "RdBook4Author")]
        
        arrayOfCellWishlist = [cellData(bookTitle: "WSBook1", bookAuthor: "WsBook1Author"),
                               cellData(bookTitle: "WSBook2", bookAuthor: "WsBook2Author"),
                               cellData(bookTitle: "WSBook3", bookAuthor: "WsBook3Author"),
                               cellData(bookTitle: "WSBook4", bookAuthor: "WsBook4Author"),
                               cellData(bookTitle: "WSBook5", bookAuthor: "WsBook5Author"),
                               cellData(bookTitle: "WSBook6", bookAuthor: "WsBook6Author")]

    }
    
    
    // Creates the relevant number of rows in the view based on the number of records in the array
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch segmentedControl.selectedSegmentIndex {
                case 0:
                    return arrayOfCellDataReading.count
                case 1:
                    return arrayOfCellDataCompleted.count
                case 2:
                    return arrayOfCellWishlist.count
                default:
                    break
                }
                return 0
        
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    
    
    //Loads the relevant data to the relevant segment control using the XIB file
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (segmentedControl.selectedSegmentIndex == 0){
            
            let cellForReading = Bundle.main.loadNibNamed("CustomTableViewCell", owner: self, options: nil)?.first as! CustomTableViewCell
            cellForReading.BookTitle.text = arrayOfCellDataReading[indexPath.row].bookTitle
            cellForReading.Author.text = arrayOfCellDataReading[indexPath.row].bookAuthor
            
            //styling
            cellForReading.contentView.layer.cornerRadius = 10
            cellForReading.contentView.frame = cellForReading.contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
            
            return cellForReading
            
        } else if (segmentedControl.selectedSegmentIndex == 1) {
            
            let cellForCompleted = Bundle.main.loadNibNamed("CustomCompletedTableViewCell", owner: self, options: nil)?.first as! CustomCompletedTableViewCell
            cellForCompleted.bookTitle.text = arrayOfCellDataCompleted[indexPath.row].bookAuthor
            cellForCompleted.bookAuthor.text = arrayOfCellDataCompleted[indexPath.row].bookAuthor
            
            //styling
            cellForCompleted.contentView.layer.cornerRadius = 10
            cellForCompleted.contentView.frame = cellForCompleted.contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
            
            return cellForCompleted
            
        } else {
            
            let cellForWishlist = Bundle.main.loadNibNamed("CustomWishListTableViewCell", owner: self, options: nil)?.first as! CustomWishListTableViewCell
            cellForWishlist.bookTitle.text = arrayOfCellWishlist[indexPath.row].bookTitle
            cellForWishlist.bookAuthor.text = arrayOfCellWishlist[indexPath.row].bookAuthor
            
            //styling
            cellForWishlist.contentView.layer.cornerRadius = 10
            cellForWishlist.contentView.frame = cellForWishlist.contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
            return cellForWishlist
        }
        
    }
    

    
    @IBAction func segmentedChanges(_ sender: UISegmentedControl) {
        tableViewControl.reloadData()
    }
}
