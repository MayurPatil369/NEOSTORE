//
//  OrderDetailsTableViewCell.swift
//  neostore
//
//  Created by Neosoft on 27/11/24.
//

import UIKit

class OrderDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productCategory: UILabel!
    
    @IBOutlet weak var productQuantity: UILabel!
    
    @IBOutlet weak var productCost: UILabel!
    
    @IBOutlet weak var productImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
