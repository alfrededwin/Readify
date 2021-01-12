//
//  HomeViewController.swift
//  Readify
//
//  Created by Adam Ameen on 2020-12-27.
//

import UIKit
import QuartzCore

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    //variables
    @IBOutlet weak var currentlyReadingBookLbl: UILabel!
    @IBOutlet weak var currentlyReadingBookImage: UIImageView!
    
    var imageArray=[UIImage(named: "Img1"),UIImage(named: "Img2"),UIImage(named: "Img3"),UIImage(named: "Img4")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeData();
        
        //to remove the background color of the collection view
        collectionView.backgroundColor = UIColor.clear

    }
    
    // This Function is for the Onboarding Screen
    override func viewDidAppear(_ animated: Bool) {
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

}
