//
//  HomeViewController.swift
//  Readify
//
//  Created by Adam Ameen on 2020-12-27.
//

import UIKit
import QuartzCore
import CoreData

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    //variables
    @IBOutlet weak var currentlyReadingBookLbl: UILabel!
    @IBOutlet weak var currentlyReadingBookImage: UIImageView!
    
    @IBOutlet weak var labelReadingCount: UILabel!
    @IBOutlet weak var labelWishListCount: UILabel!
    @IBOutlet weak var labelMostReadBook: UILabel!
    
    
    @IBOutlet weak var currBookImage: UIImageView!
    @IBOutlet weak var currBookTitle: UILabel!
    
    var currReadingBook: Book?
    
    var imageArray=[UIImage(named: "Img1"),UIImage(named: "Img2"),UIImage(named: "Img3"),UIImage(named: "Img4")]
    var arr = [String]()
    var sectionArr = [Any] ()
    
    var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>!
    
    var context: NSManagedObjectContext? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        return appDelegate.persistentContainer.viewContext
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeData();
        
        //to remove the background color of the collection view
        collectionView.backgroundColor = UIColor.clear

        labelReadingCount.text = "0"
        labelWishListCount.text = "0"
    }
    
    // This Function is for the Onboarding Screen
    override func viewDidAppear(_ animated: Bool) {
        currReadingBook = nil
        
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
        do {
            
            let bookList: [BookList] = try context?.fetch(fetchRequest) as! [BookList]
            
            for list in bookList {
                
                if list.name == "Completed List" {
                    labelReadingCount.text = String(list.books?.count ?? 0)
                }
                
                if list.name == "Wish List" {
                    labelWishListCount.text = String(list.books?.count ?? 0)
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
            
            for book in books {
                if book.booklist?.name == "Reading List" {
                    currReadingBook = book
                    break
                }
            }
            
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
        
        if let currBook = currReadingBook {
            
            currBookTitle.text = currBook.title
            
            if let image = currBook.image {
                currBookImage.isHidden = false
                currBookImage.image = UIImage(data: image)
            }
        } else {
            currBookImage.isHidden = true
            currBookTitle.text = "Reading list empty"
        }
        
        // user onboarding
        if UserDefaults.standard.bool(forKey: "hasViewOnboarding") {
            return
        }
        let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
        if let onboardingViewController = storyboard.instantiateViewController(withIdentifier: "OnboardingViewController") as? OnboardingViewController {
            present(onboardingViewController, animated: true, completion: nil)
        }
    }
    
    func initializeData(){
        currentlyReadingBookLbl.text = "The Jungle Book"
        currentlyReadingBookImage.image = UIImage(named: "JungleBook - Season1")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCollectionViewCell", for: indexPath) as! ImageCollectionViewCell
        cell.imgItem.image = imageArray[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) -> Void {
        let indexValue :String = String(format: "%d", indexPath.row)
        
        print(indexValue)
        if (indexValue == "0"){
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "AddBooksViewController")
            self.present(vc, animated: true)
            print("1st")
        } else if (indexValue == "1") {
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "AnalyticsViewController")
            self.present(controller, animated: true, completion: nil)
            print("2nd")
        } else if (indexValue == "2") {
            print("3rd")
        } else {
            print("4th")
        }
    }
    
    

}

extension HomeViewController: NSFetchedResultsControllerDelegate {
    
}
