//
//  ProductImageCell.swift
//  neostore
//
//  Created by Neosoft on 05/12/24.
//

import UIKit

class ProductImageCell: UICollectionViewCell {
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        imageView.layer.borderWidth = 2.0
//        imageView.layer.borderColor = UIColor.gray.cgColor
//        imageView.layer.cornerRadius = 8.0
//        imageView.clipsToBounds = true
    }
}
