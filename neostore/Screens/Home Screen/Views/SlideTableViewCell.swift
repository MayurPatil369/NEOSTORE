//
//  SlideTableViewCell.swift
//  neostore
//
//  Created by Neosoft on 11/11/24.
//

import UIKit

class SlideTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var MenuTableImgView: UIImageView!
    
    @IBOutlet weak var MenuTableTitleText: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
