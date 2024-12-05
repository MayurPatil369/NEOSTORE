//
//  RatePopUpViewController.swift
//  neostore
//
//  Created by Neosoft on 15/11/24.
//

import UIKit

protocol ProductRatingDelegate {
    func ratingAdded(req: RatingRequest)
}

class RatePopUpViewController: UIViewController, StarRatingViewDelegate {

    @IBOutlet weak var productname: UILabel!
    
    @IBOutlet weak var productImg: UIImageView!
        
    @IBOutlet weak var rateNowBtn: UIButton!
    
    @IBOutlet weak var starRating: StarRatingView!
    
    var stars: Int = 0
    var product: productDetailsData?
    var prodID: Int = 0
    var productRatingDelegate: ProductRatingDelegate?

    private var selectedRate: Int = 0
    var productRatingViewModel = RatingPopUpViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        assert(stars >= 0 && stars <= 5, "Invalid stars value. It must be between 0 and 5.")
        
        starRating.filledStarImage = UIImage(named: Constants.star_check)
        starRating.emptyStarImage = UIImage(named: Constants.star_uncheck)
        starRating.rating = CGFloat(stars)
        starRating.starSize = CGSize(width: 30, height: 30)
        starRating.spacing = 5
        starRating.delegate = self
        
        selectedRate = stars
        
        self.view.backgroundColor = .black.withAlphaComponent(0.5)
        
        setUpData()
        addDismissGesture()
        addGestureToStarRating()
    }

    func setUpData() {
           guard let product else { return }
           productname.text = product.name
           if let imageUrl = product.product_images?.first?.image, let url = URL(string: imageUrl) {
               productImg.loadImage(from: url)
           }
       }

       func didUpdateRating(_ rating: Int) {
           selectedRate = rating
       }

    private func addGestureToStarRating() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didSelectRate))
        starRating.addGestureRecognizer(tapGesture)
    }

    
    @objc func didSelectRate(gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: starRating)
        let starWidth = starRating.starSize.width
        let rate = Int(location.x / starWidth) + 1
        
        if rate != selectedRate {
            starRating.rating = CGFloat(rate)
            selectedRate = rate
        }
    }

    @IBAction func RateNowBtnClicked(_ sender: Any) {


             let req = RatingRequest(product_id: String(prodID), rating: selectedRate)
             
             productRatingViewModel.rateRequest(logs: req) { [weak self] success in
                 if success {
                     self?.productRatingDelegate?.ratingAdded(req: req)
                     self?.dismiss(animated: true)
                 } else {
                     let alert = UIAlertController(title: AlertConstants.Success, message: "Rating submitted successfully.", preferredStyle: .alert)
                     alert.addAction(UIAlertAction(title: AlertConstants.OK, style: .default, handler: { [weak self] _ in
                         self?.dismiss(animated: true)
                     }))
                     self?.present(alert, animated: true)
                 }
             }
    }

    func addDismissGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissPopup))
        self.view.addGestureRecognizer(tapGesture)
    }

    @objc func dismissPopup() {
        dismiss(animated: true)
    }
    

}

