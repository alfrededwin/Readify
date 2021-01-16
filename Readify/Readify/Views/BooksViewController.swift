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
    
    var listMode: Int!
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
        
        arrayOfCellWishlist = getBooksByList(listName: "Wish List")
        arrayOfCellDataReading = getBooksByList(listName: "Reading List")
        arrayOfCellDataCompleted = getBooksByList(listName: "Completed List")
        
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
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        if (segmentedControl.selectedSegmentIndex == 0) { // reading list
            
            let cellForReading = Bundle.main.loadNibNamed("CustomTableViewCell", owner: self, options: nil)?.first as! CustomTableViewCell
            
            cellForReading.bookTitle.text = arrayOfCellDataReading[indexPath.row].title ?? ""
            cellForReading.bookAuthor.text = arrayOfCellDataReading[indexPath.row].author ?? ""
            
            if let image = arrayOfCellDataReading[indexPath.row].image {
                cellForReading.bookImage.image = UIImage(data: image)
            }
            
            if let readingStartDate = arrayOfCellDataReading[indexPath.row].reading_started_at {
                cellForReading.labelStartReading.text = "Started Reading: " + dateFormatter.string(from: readingStartDate)
            }
            
            if let lastReadDate = arrayOfCellDataReading[indexPath.row].progress_updated_at {
                cellForReading.labelLastRead.text = "Last Reading: " + dateFormatter.string(from: lastReadDate)
            }
            
            //styling
            cellForReading.contentView.layer.cornerRadius = 10
            cellForReading.contentView.frame = cellForReading.contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
            
            return cellForReading
            
        } else if (segmentedControl.selectedSegmentIndex == 1) { // completed list
            
            let cellForCompleted = Bundle.main.loadNibNamed("CustomCompletedTableViewCell", owner: self, options: nil)?.first as! CustomCompletedTableViewCell
            cellForCompleted.bookTitle.text = arrayOfCellDataCompleted[indexPath.row].title ?? ""
            cellForCompleted.bookAuthor.text = arrayOfCellDataCompleted[indexPath.row].author ?? ""
            
            if let image = arrayOfCellDataCompleted[indexPath.row].image {
                cellForCompleted.bookImage.image = UIImage(data: image)
            }
            
            if let readingStartDate = arrayOfCellDataCompleted[indexPath.row].reading_started_at {
                cellForCompleted.labelStartReading.text = "Started Reading: " + dateFormatter.string(from: readingStartDate)
            }
            
            if let completedDate = arrayOfCellDataCompleted[indexPath.row].reading_completed_at {
                cellForCompleted.labelCompletedOn.text = "Completed On: " + dateFormatter.string(from: completedDate)
            }
            
            
            //styling
            cellForCompleted.contentView.layer.cornerRadius = 10
            cellForCompleted.contentView.frame = cellForCompleted.contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
            
            return cellForCompleted
            
        } else { // wish list
            
            let cellForWishlist = Bundle.main.loadNibNamed("CustomWishListTableViewCell", owner: self, options: nil)?.first as! CustomWishListTableViewCell
            cellForWishlist.bookTitle.text = arrayOfCellWishlist[indexPath.row].title ?? ""
            cellForWishlist.bookAuthor.text = arrayOfCellWishlist[indexPath.row].author ?? ""
            
            if let image = arrayOfCellWishlist[indexPath.row].image {
                cellForWishlist.bookImage.image = UIImage(data: image)
            }
            
            if let addedDate = arrayOfCellWishlist[indexPath.row].created_at {
                cellForWishlist.labelAddedDate.text = "Added Date: " + dateFormatter.string(from: addedDate)
            }
                
            cellForWishlist.labelTotalPages.text = "Total pages: " + String(arrayOfCellWishlist[indexPath.row].page_count)
            
            //styling
            cellForWishlist.contentView.layer.cornerRadius = 10
            cellForWishlist.contentView.frame = cellForWishlist.contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
            return cellForWishlist
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath)
        performSegue(withIdentifier: "bookDetailView", sender: cell)
    }

    @IBAction func segmentedChanges(_ sender: UISegmentedControl) {
        tableViewControl.reloadData()
    }
    
    // return list of books by given list name
    private func getBooksByList(listName: String) -> [Book] {
        
        var listOfBooks = [Book]()
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "BookList")
        let fetchSort = NSSortDescriptor(key: "name", ascending: true)
        
        fetchRequest.sortDescriptors = [fetchSort]
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.context!, sectionNameKeyPath: nil, cacheName: nil)
         
        fetchedResultsController.delegate = self
        
        let predicate = NSPredicate(format: "name == %@", listName)
        fetchedResultsController.fetchRequest.predicate = predicate
        
        do {
            try fetchedResultsController.performFetch()
        } catch let error as NSError {
            print("Unable to perform fetch: \(error.localizedDescription)")
        }
        
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            
            let bookList: [BookList] = try context?.fetch(fetchRequest) as! [BookList]
            
            for list in bookList {
                listOfBooks += list.books?.allObjects as! [Book]
            }
            
        } catch {
            let error = error
            print(error)
        }
        
        return listOfBooks
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch (segue.identifier ?? "") {
        case "addBook":
            
            guard let addBooksViewController = segue.destination as? AddBooksViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            addBooksViewController.context = self.context
            
        case "bookDetailView":
            
            guard let bookDetailsViewController = segue.destination as? DetailsViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            
            var book: Book!
            
            switch segmentedControl.selectedSegmentIndex {
            case 0:
                guard let seletedBookCell = sender as? CustomTableViewCell else {
                    fatalError("Unexpected sender \(String(describing: sender))")
                }
                
                guard let indexPath = tableViewControl.indexPath(for: seletedBookCell) else {
                    fatalError("The selected cell is not being displayed by the table")
                }
                
                book = arrayOfCellDataReading[indexPath.row]
            case 1:
                guard let seletedBookCell = sender as? CustomCompletedTableViewCell else {
                    fatalError("Unexpected sender \(String(describing: sender))")
                }
                
                guard let indexPath = tableViewControl.indexPath(for: seletedBookCell) else {
                    fatalError("The selected cell is not being displayed by the table")
                }
                
                book = arrayOfCellDataCompleted[indexPath.row]
            default:
                guard let seletedBookCell = sender as? CustomWishListTableViewCell else {
                    fatalError("Unexpected sender \(String(describing: sender))")
                }
                
                guard let indexPath = tableViewControl.indexPath(for: seletedBookCell) else {
                    fatalError("The selected cell is not being displayed by the table")
                }
                
                book = arrayOfCellWishlist[indexPath.row]
            }
            
            
            bookDetailsViewController.book = book
            bookDetailsViewController.context = context
            bookDetailsViewController.listMode = segmentedControl.selectedSegmentIndex
            
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
    }
}

extension BooksViewController: NSFetchedResultsControllerDelegate {
    
    /*
     
     We manually control this with viewDidAppear as we have higly customized cells
    
     */
    
    /*func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
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
    }*/
    
}
