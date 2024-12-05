//
//  ProductsTableViewCell.swift
//  neostore
//
//  Created by Neosoft on 12/11/24.
//

import UIKit

class ProductsTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productProducer: UILabel!
    @IBOutlet weak var productImg: UIImageView!
    
    @IBOutlet weak var productCost: UILabel!
    
    @IBOutlet weak var starRating: StarRatingView!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
        starRating.filledStarImage = UIImage(named: "star_check")
        starRating.emptyStarImage = UIImage(named: "star_unchek")
        
        starRating.starSize = CGSize(width: 30, height: 30)
                starRating.spacing = 5
                
    }
    
}
