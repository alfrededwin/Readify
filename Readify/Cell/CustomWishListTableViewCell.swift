//
//  CustomWishListTableViewCell.swift
//  Readify
//
//  Created by Adam Ameen on 2021-01-14.
//

import UIKit

class CustomWishListTableViewCell: UITableViewCell {

    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var bookAuthor: UILabel!
    @IBOutlet weak var bookImage: UIImageView!
    
    
    @IBOutlet weak var labelAddedDate: UILabel!
    @IBOutlet weak var labelTotalPages: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func customInit(text: String, author: String, image: UIImage ) {
        self.bookTitle.text = text
        self.bookAuthor.text = author
        self.bookImage.image = image
        
        self.bookTitle.textColor = UIColor.white
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }
}
