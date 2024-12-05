//
//  ProductDetailsCollectionViewExtension.swift
//  neostore
//
//  Created by Neosoft on 05/12/24.
//

import UIKit

extension ProductDetailsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productImages.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ProductImageCell
        
        let imageUrl = productImages[indexPath.row]
        
        if let url = URL(string: imageUrl) {
            cell.imageView.loadImage(from: url)
        }
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedImageUrl = productImages[indexPath.item]
        
        if let url = URL(string: selectedImageUrl) {
            productImage.loadImage(from: url)
        }
        collectionView.cellForItem(at: indexPath)?.layer.borderWidth = 2
        collectionView.cellForItem(at: indexPath)?.layer.borderColor = UIColor.black.cgColor
    }
    
 
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        collectionView.cellForItem(at: indexPath)?.layer.backgroundColor = UIColor.clear.cgColor
        collectionView.cellForItem(at: indexPath)?.layer.borderWidth = 2

    }
}
