//
//  AddressListTableViewCell.swift
//  neostore
//
//  Created by Neosoft on 15/11/24.
//

import UIKit

class AddressListTableViewCell: UITableViewCell {

    @IBOutlet weak var fullname: UILabel!
    
    @IBOutlet weak var address: UILabel!
    
    @IBOutlet weak var selectedImg: UIImageView!
    
    var isCheck = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
