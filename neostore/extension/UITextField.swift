//
//  SetIcon.swift
//  neostore
//
//  Created by Neosoft on 28/10/24.
//

import UIKit

extension UITextField {
    
    func setIcon(_ icon: UIImage, padding: CGFloat = 8, iconSize: CGSize = CGSize(width: 24, height: 24)) {
        let iconContainerView = UIView(frame: CGRect(x: 0, y: 0, width: iconSize.width + padding * 2, height: iconSize.height))
        
        let iconImageView = UIImageView(frame: CGRect(x: padding, y: 0, width: iconSize.width, height: iconSize.height - 5))
        iconImageView.image = icon
        iconImageView.contentMode = .scaleAspectFit
        
        iconContainerView.addSubview(iconImageView)
        
        leftView = iconContainerView
        leftViewMode = .always
    }
    
    func setPlaceholder(color: UIColor) {
        guard let placeholderText = placeholder else { return }
        attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: [.foregroundColor: color])
    }
    
    func setBorder(color: UIColor, width: CGFloat = 1.0) {
            self.layer.borderColor = color.cgColor
            self.layer.borderWidth = width
            self.clipsToBounds = true
        }
    
}

