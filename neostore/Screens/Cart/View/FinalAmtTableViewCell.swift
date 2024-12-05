//
//  FinalAmtTableViewCell.swift
//  neostore
//
//  Created by Neosoft on 21/11/24.
//

import UIKit

class FinalAmtTableViewCell: UITableViewCell {

    @IBOutlet weak var totalcost: UILabel!
    
    @IBOutlet weak var totallbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
