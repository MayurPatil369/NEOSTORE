//
//  productDetailsViewController.swift
//  neostore
//
//  Created by Neosoft on 13/11/24.
//

import UIKit

class ProductDetailsViewController: UIViewController {

    
    @IBOutlet weak var productName: UILabel!

    @IBOutlet weak var productCategory: UILabel!
    
    @IBOutlet weak var productProducer: UILabel!
    
    @IBOutlet weak var productCost: UILabel!
    
    @IBOutlet weak var shareBtn: UIButton!
    
    @IBOutlet weak var productImage: UIImageView!
    
    @IBOutlet weak var leftProductImg: UIImageView!
    
    @IBOutlet weak var middleProductImg: UIImageView!
    
    @IBOutlet weak var rightProductImg: UIImageView!
    
    @IBOutlet weak var buyNowBtn: UIButton!
    
    @IBOutlet weak var rateBtn: UIButton!
    
    @IBOutlet weak var starRating: StarRatingView!
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    var productImages: [String] = []
    
    lazy var cartViewModel = CartViewModel()
    var cartViewController : CartViewController?
    lazy var productDetailviewModel = ProductDetailViewModel()
    lazy var productRatingViewModel = RatingPopUpViewModel()
    
    var stars : Int?
    var prodHead : String!
    var prodCatg : String!
    var prodDes : String!
    var prodRate : Int!
    var prodPrc: String!
    var prodImg: String!
    var prodID: Int!
    var prodQuantity: Int!
    var prodViewCount: Int!
    var product:productDetailsData?
    
    var category:String = "Mayur"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        
        bindViewModel()
        
        starRating.filledStarImage = UIImage(named: Constants.star_check)
        starRating.emptyStarImage = UIImage(named: Constants.star_uncheck)
        
        starRating.rating = CGFloat(stars ?? 4)
        starRating.starSize = CGSize(width: 30, height: 30)
        starRating.spacing = 5
        starRating.rating = CGFloat(stars!)

        let req = productDetailsRequest(product_id: (self.prodID ?? 0))
        initViewModel(req: req)
    }
    
    func initViewModel(req: productDetailsRequest){
        productDetailviewModel.fetchProducts(dataTab: req)
    }

    private func bindViewModel() {
        productDetailviewModel.eventHandler = { [weak self] event in
            guard let self = self else { return }
            
            switch event {
            case .loading:
                print(EventConstants.Loading)
            case .stopLoading:
                print(EventConstants.StoppedLoading)
            case .dataLoaded:
                DispatchQueue.main.async {
                    self.setUpData()
                }
            case .error(let error):
                print("Error fetching product details:", error ?? "Unknown error")
            }
        }
    }
    
    
    
    func setUpData(){
       
        self.product = self.productDetailviewModel.products
        productCategory.text = category
        self.title = product?.name
        
        if let images = product?.product_images {
            self.productImages = images.compactMap { $0.image }
        }
        
        myCollectionView.reloadData()
        
        switch product?.product_category_id{
        case 1 :
            productCategory.text = "Category-Tables"
        case 2 :
            productCategory.text = "Category-Chairs"
        case 3 :
            productCategory.text = "Category-Sofa"
        case 4 :
            productCategory.text = "Category-Cupboards"
        default:
            break
        }
        
        productName.text = product?.name
        productProducer.text = product?.producer
        productCost.text = "Rs. \(product?.cost ?? 0)"
      
        
        if let firstImageUrl = productImages.first, let url = URL(string: firstImageUrl) {
            productImage.loadImage(from: url)
        }
    }
    @IBAction func shareBtnClicked(_ sender: Any) {
        let productTitle = productName.text
        let productcat = productCategory.text

            let itemsToShare: [Any] = [productTitle ?? "", productcat ?? ""]

            let activityVC = UIActivityViewController(activityItems: itemsToShare, applicationActivities: nil)

            activityVC.excludedActivityTypes = [
                .addToReadingList,
                .assignToContact,
                .print
            ]

            present(activityVC, animated: true)
    }
    
    @IBAction func RateBtnclicked(_ sender: Any) {
        let popup = RatePopUpViewController()
        popup.product = productDetailviewModel.products
        popup.modalPresentationStyle = .overCurrentContext
        popup.modalTransitionStyle = .coverVertical
        present(popup, animated: true)
        
 
        
    
    }
    @IBAction func buyNowBtnClicked(_ sender: Any) {

        let popup = EnterQtyViewController()
        popup.data = product
        popup.prodImg = prodImg
        popup.prodLbl = self.productDetailviewModel.products?.name
        popup.prodId = self.productDetailviewModel.products?.id
        popup.productQuantityDelegate = self
        popup.modalTransitionStyle = .crossDissolve
        popup.modalPresentationStyle = .overFullScreen
        popup.delegate = self
    
        present(popup, animated: true)
        
    }
    
}
extension ProductDetailsViewController: ProductQuantityDelegate {
    func quantityAdded() {
        let storyboard = UIStoryboard(name: "Cart", bundle: nil)
        if let cartVC = storyboard.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController {
            cartVC.product = productDetailviewModel.products
            self.navigationController?.pushViewController(cartVC, animated: true)
        }
    }

    
    func onDismiss() {
        let storyboard = UIStoryboard(name: "Cart", bundle: nil)
        if let cartVC = storyboard.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController {
            cartVC.product = productDetailviewModel.products
           cartVC.productQty = prodQuantity
            self.navigationController?.pushViewController(cartVC, animated: true)
        }

    }
}
