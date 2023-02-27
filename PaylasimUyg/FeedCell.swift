//
//  FeedCell.swift
//  PaylasimUyg
//
//  Created by imrahor on 11.02.2023.
//

import UIKit

class FeedCell: UITableViewCell {

    @IBOutlet weak var emaiiText: UILabel!
    @IBOutlet weak var tabImageView: UIImageView!
    @IBOutlet weak var yorumText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
