//
//  UpdateProgressViewController.swift
//  Readify
//
//  Created by Adam Ameen on 2021-01-15.
//

import UIKit

class UpdateProgressViewController: UIViewController {

   
    @IBOutlet weak var txtNumberOfPages: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func cancelModal(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func saveProgress(_ sender: Any) {
        if (txtNumberOfPages.text == ""){
            
            showAlert(title: "No data to save", message: "Enter the number of pages you have read")
            
        } else {
            
            let alert = UIAlertController(title: "Please Confirm", message: "Would you like to confirm the updates?", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Continue", style: UIAlertAction.Style.default, handler: nil))
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
    
    private func showAlert(title: String, message: String) -> Void {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }

}
