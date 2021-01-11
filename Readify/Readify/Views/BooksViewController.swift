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

class BooksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var tableViewControl: UITableView!
    
//    let reading = ["Harry Potter", "Game of Thrones"]
//    let completed = ["Harry Potter 1"]
//    let wishlist = ["Narnia"]
    
    var data = [
            ["J.K.Rowling HarryPotter", "Stalen GameofThrones"],
            ["J.K.Rowling HarryPotter1", "Stalen GameofThrones2"],
            ["EDWIN HarryPotter", "ALFRED GameofThrones"]
        ]
    
    var p: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        tableViewControl.delegate = self
//        tableViewControl.dataSource = self
        let nib = UINib(nibName: "CustomTableViewCell", bundle: nil)
        tableViewControl.register(nib, forCellReuseIdentifier: "customCell")
        
        p=0;
//         Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        switch segmentedControl.selectedSegmentIndex {
//                case 0:
//                    return reading.count
//                case 1:
//                    return completed.count
//                case 2:
//                    return wishlist.count
//                default:
//                    break
//                }
//                return 0
        
        return data[p].count
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
//
//         switch segmentedControl.selectedSegmentIndex {
//         case 0:
//             cell.textLabel?.text = reading[indexPath.row]
//         case 1:
//             cell.textLabel?.text = completed[indexPath.row]
//         case 2:
//             cell.textLabel?.text = wishlist[indexPath.row]
//         default:
//             break
//         }
//         return cell
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! CustomTableViewCell
        let str = data[p][indexPath.row].components(separatedBy: " ")
        cell.customInit(text: str[1], author: str[0])
    
        cell.contentView.layer.cornerRadius = 10
        cell.contentView.frame = cell.contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        return cell
        
        
        
        
    }
    

    @IBAction func segmentedChanges(_ sender: UISegmentedControl) {
        p = sender.selectedSegmentIndex
        tableViewControl.reloadData()
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
