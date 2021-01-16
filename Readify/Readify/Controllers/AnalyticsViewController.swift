//
//  AnalyticsViewController.swift
//  Readify
//
//  Created by Alfred Edwin on 2021-01-12.
//
// Reference :  https://www.youtube.com/watch?v=J9hl7HHXNHU
// https://www.youtube.com/watch?v=GNf-SsDBQ20&t=501s

import Charts
import UIKit
import CoreData

class AnalyticsViewController: UIViewController {
     
    struct bookListStats {
        let listName: String!
        let listCount: Int!
    }
    
    @IBOutlet weak var pieChart: PieChartView!
    
    
    @IBOutlet weak var labelReadingCount: UILabel!
    @IBOutlet weak var labelWIshListCount: UILabel!
    
    @IBOutlet weak var labelMostReadBook: UILabel!
    
    var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>!
    
    var context: NSManagedObjectContext? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        return appDelegate.persistentContainer.viewContext
    }
    
    var bookCountStat = [bookListStats]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelReadingCount.text = "0"
        labelWIshListCount.text = "0"
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        var entries = [ChartDataEntry]()

        for item in bookCountStat {
            entries.append(ChartDataEntry(x: Double(item.listCount),
                                          y: Double(item.listCount),
                                          data: String(item.listName!)))
            
            print("listName: \(item.listName!) - listCount: \(item.listCount)")
            
        }

        let set = PieChartDataSet(entries: entries)
        set.colors = ChartColorTemplates.material()
        let data = PieChartData(dataSet: set)
        pieChart.data = data
    }

    override func viewDidAppear(_ animated: Bool) {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "BookList")
        let fetchSort = NSSortDescriptor(key: "name", ascending: true)
        
        fetchRequest.sortDescriptors = [fetchSort]
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.context!, sectionNameKeyPath: nil, cacheName: nil)
         
        fetchedResultsController.delegate = self
        
        do {
            try fetchedResultsController.performFetch()
        } catch let error as NSError {
            print("Unable to perform fetch: \(error.localizedDescription)")
        }
        
        fetchRequest.returnsObjectsAsFaults = false
        
        // get all the categories
        bookCountStat = [bookListStats]()
        do {
            
            let bookList: [BookList] = try context?.fetch(fetchRequest) as! [BookList]
            
            for list in bookList {
                bookCountStat.append(bookListStats(listName: list.name!, listCount: list.books?.count))
                
                if list.name == "Completed List" {
                    labelReadingCount.text = String(list.books?.count ?? 0)
                }
                
                if list.name == "Wish List" {
                    labelWIshListCount.text = String(list.books?.count ?? 0)
                }
            }
            
        } catch {
            let error = error
            print(error)
        }
        
        
        let fetchRequest2 = NSFetchRequest<NSFetchRequestResult>(entityName: "Book")
        let fetchSort2 = NSSortDescriptor(key: "reading_started_at", ascending: false)
        
        fetchRequest2.sortDescriptors = [fetchSort2]
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest2, managedObjectContext: self.context!, sectionNameKeyPath: nil, cacheName: nil)
         
        fetchedResultsController.delegate = self
        
        do {
            try fetchedResultsController.performFetch()
        } catch let error as NSError {
            print("Unable to perform fetch: \(error.localizedDescription)")
        }
        
        fetchRequest2.returnsObjectsAsFaults = false
        
        do {
            
            let books: [Book] = try context?.fetch(fetchRequest2) as! [Book]
            
            var maxPercentage: Double = 0.0
            var mostReadBook: Book?
            
            for book in books {
            
                if ((Double(book.current_page)/Double(book.page_count)) > maxPercentage) {
                    maxPercentage = (Double(book.current_page)/Double(book.page_count))
                    mostReadBook = book
                }
                
            }
            
            if let topBook = mostReadBook {
                labelMostReadBook.text = topBook.title
            } else {
                labelMostReadBook.text = "N/A"
            }
            
        } catch {
            let error = error
            print(error)
        }
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

extension AnalyticsViewController: NSFetchedResultsControllerDelegate {
    
}
