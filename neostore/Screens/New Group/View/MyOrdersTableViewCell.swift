//
//  MyOrdersTableViewCell.swift
//  neostore
//
//  Created by Neosoft on 28/11/24.
//

import UIKit

class MyOrdersTableViewCell: UITableViewCell {
    @IBOutlet weak var orderID: UILabel!
    
    @IBOutlet weak var orderDate: UILabel!
    
    @IBOutlet weak var orderCost: UILabel!
    
    var order: OrderData? {
        didSet {
            configuration()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configuration(){
        guard let order else {return}
        
        orderID.text = String(order.id)
        orderDate.text = order.created
        orderCost.text = String(order.cost)
    }
    
}
