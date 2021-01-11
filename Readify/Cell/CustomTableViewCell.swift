//
//  CustomTableViewCell.swift
//  Readify
//
//  Created by Alfred Edwin on 2021-01-10.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var BookTitle: UILabel!
    
    @IBOutlet weak var Author: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func customInit(text: String, author: String ) {
        self.BookTitle.text = text
        self.Author.text = author
        
        self.BookTitle.textColor = UIColor.white
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }
    
}
