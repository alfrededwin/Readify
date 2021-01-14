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
import CoreData


class BooksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>!
    
    var context: NSManagedObjectContext? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        return appDelegate.persistentContainer.viewContext
    }
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableViewControl: UITableView!
    var arrayOfCellDataCompleted = [Book]()
    var arrayOfCellDataReading = [Book]()
    var arrayOfCellWishlist = [Book]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewControl.delegate = self
        tableViewControl.dataSource = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "BookList")
        let fetchSort = NSSortDescriptor(key: "name", ascending: true)
        
        fetchRequest.sortDescriptors = [fetchSort]
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.context!, sectionNameKeyPath: nil, cacheName: nil)
         
        fetchedResultsController.delegate = self
        
        // get books in wish list
        let wishPredicate = NSPredicate(format: "name contains[c] %@", "Wish List")
        fetchedResultsController.fetchRequest.predicate = wishPredicate
        
        do {
            try fetchedResultsController.performFetch()
        } catch let error as NSError {
            print("Unable to perform fetch: \(error.localizedDescription)")
        }
        
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let bookList: [BookList] = try context?.fetch(fetchRequest) as! [BookList]
            
            var wishListBooks = [Book]()
            for list in bookList {
                wishListBooks += list.books?.allObjects as! [Book]
            }
            
            arrayOfCellWishlist = wishListBooks
            
        } catch {
            let error = error
            print(error)
        }
        
        // get book in reading
        let readingPredicate = NSPredicate(format: "name contains[c] %@", "Reading List")
        fetchedResultsController.fetchRequest.predicate = readingPredicate
        
        do {
            try fetchedResultsController.performFetch()
        } catch let error as NSError {
            print("Unable to perform fetch: \(error.localizedDescription)")
        }
        
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let bookList: [BookList] = try context?.fetch(fetchRequest) as! [BookList]
    
            var readingBooks = [Book]()
            for list in bookList {
                readingBooks += list.books?.allObjects as! [Book]
            }
            
            arrayOfCellDataReading = readingBooks
            
        } catch {
            let error = error
            print(error)
        }
        
        // get book in completed
        let completedPredicate = NSPredicate(format: "name contains[c] %@", "Completed List")
        fetchedResultsController.fetchRequest.predicate = completedPredicate
        
        do {
            try fetchedResultsController.performFetch()
        } catch let error as NSError {
            print("Unable to perform fetch: \(error.localizedDescription)")
        }
        
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let bookList: [BookList] = try context?.fetch(fetchRequest) as! [BookList]
            
            var completedBooks = [Book]()
            for list in bookList {
                completedBooks += list.books?.allObjects as! [Book]
            }
            
            arrayOfCellDataCompleted = completedBooks
            
        } catch {
            let error = error
            print(error)
        }
        
        tableViewControl.reloadData()
        
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
            
            cellForReading.bookTitle.text = arrayOfCellDataReading[indexPath.row].title
            cellForReading.bookAuthor.text = arrayOfCellDataReading[indexPath.row].author
            
            if let image = arrayOfCellDataReading[indexPath.row].image {
                cellForReading.bookImage.image = UIImage(data: image)
            }
            
            
            //styling
            cellForReading.contentView.layer.cornerRadius = 10
            cellForReading.contentView.frame = cellForReading.contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
            
            return cellForReading
            
        } else if (segmentedControl.selectedSegmentIndex == 1) {
            
            let cellForCompleted = Bundle.main.loadNibNamed("CustomCompletedTableViewCell", owner: self, options: nil)?.first as! CustomCompletedTableViewCell
            cellForCompleted.bookTitle.text = arrayOfCellDataCompleted[indexPath.row].title
            cellForCompleted.bookAuthor.text = arrayOfCellDataCompleted[indexPath.row].author
            
            if let image = arrayOfCellDataCompleted[indexPath.row].image {
                cellForCompleted.bookImage.image = UIImage(data: image)
            }
            
            //styling
            cellForCompleted.contentView.layer.cornerRadius = 10
            cellForCompleted.contentView.frame = cellForCompleted.contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
            
            return cellForCompleted
            
        } else {
            
            let cellForWishlist = Bundle.main.loadNibNamed("CustomWishListTableViewCell", owner: self, options: nil)?.first as! CustomWishListTableViewCell
            cellForWishlist.bookTitle.text = arrayOfCellWishlist[indexPath.row].title
            cellForWishlist.bookAuthor.text = arrayOfCellWishlist[indexPath.row].author
            
            if let image = arrayOfCellWishlist[indexPath.row].image {
                cellForWishlist.bookImage.image = UIImage(data: image)
            }
            
            //styling
            cellForWishlist.contentView.layer.cornerRadius = 10
            cellForWishlist.contentView.frame = cellForWishlist.contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
            return cellForWishlist
        }
        
    }
    

    @IBAction func segmentedChanges(_ sender: UISegmentedControl) {
        tableViewControl.reloadData()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch (segue.identifier ?? "") {
        case "addBook":
            
            guard let addBooksViewController = segue.destination as? AddBooksViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            addBooksViewController.context = self.context
            
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
    }
}

extension BooksViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableViewControl.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableViewControl.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let indexPath = newIndexPath {
                tableViewControl.insertRows(at: [indexPath], with: .fade)
            }
            break
            
        case .delete:
            if let indexPath = indexPath {
                tableViewControl.deleteRows(at: [indexPath], with: .fade)
            }
            break
            
        case .update:
            if let indexPath = indexPath, let cell = tableViewControl.cellForRow(at: indexPath) as? CustomTableViewCell {
//                configureCell(cell, at: indexPath)
            }
            break
            
        case .move:
            if let indexPath = indexPath {
                tableViewControl.deleteRows(at: [indexPath], with: .fade)
            }
            if let newIndexPath = newIndexPath {
                tableViewControl.insertRows(at: [newIndexPath], with: .fade)
            }
            break
        default:
            break
        }
    }
    
//    func configureCell(_ cell: CustomTableViewCell, at indexPath: IndexPath) {
//        let book = fetchedResultsController.object(at: indexPath) as! Book
//
//        var author: String = "";
//        if let authours = book.authors!.allObjects as? [Author] {
//
//            for item in authours {
//                author = "\(author), \(item)"
//            }
//        }
//
//        cell.customInit(text: book.title!, author: author)
//    }
}
