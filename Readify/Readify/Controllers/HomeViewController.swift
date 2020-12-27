//
//  HomeViewController.swift
//  Readify
//
//  Created by Adam Ameen on 2020-12-27.
//

import UIKit
import QuartzCore

class HomeViewController: UIViewController {

    //variables
    @IBOutlet weak var currentlyReadingBookLbl: UILabel!
    @IBOutlet weak var currentlyReadingBookImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeData();
        

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

}
