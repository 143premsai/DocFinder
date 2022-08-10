//
//  DoctorsCell.swift
//  DocFinder
//
//  Created by Rahul Sharma on 08/08/22.
//

import UIKit

class DoctorsCell: UITableViewCell {

    @IBOutlet weak var doctorImageView: UIImageView!
    @IBOutlet weak var doctorNameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var doctorTypeLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backView.makeBorderWidth(width: 2, color: .black)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
