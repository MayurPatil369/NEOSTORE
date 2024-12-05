//
//  EnterQtyViewController.swift
//  neostore
//
//  Created by Neosoft on 15/11/24.
//

import UIKit

protocol ProductQuantityDelegate{
    func onDismiss()
    func quantityAdded()
}

class EnterQtyViewController: UIViewController {
    let sb = UIStoryboard(name: SbConstants.Cart, bundle: nil)
    
    @IBOutlet weak var productname: UILabel!
    @IBOutlet weak var productImg: UIImageView!
    
    @IBOutlet weak var enterQtytf: UITextField!
    @IBOutlet weak var submitBtnClicked: UIButton!
    
    var delegate: ProductQuantityDelegate?
       var data: productDetailsData?
       var productQuantityDelegate: ProductQuantityDelegate?
       var cartViewController: CartViewController?
       var prodImg: String!
       var prodLbl: String!
       var prodId: Int!
       var quantity: String!
       lazy var cartViewModel = CartViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
            setUpData()

        productname.text = prodLbl
        enterQtytf.keyboardType = .numberPad
        print(prodId!)
        
        self.view.backgroundColor = .black.withAlphaComponent(0.5)
        addDismissGesture()
    }


    func setUpData(){
        guard let data else{return}
        productname.text = data.name
        if let imgurl = URL(string: data.product_images?[0].image ?? ""){
            productImg.loadImage(from: imgurl)
        }
    }
    
    
    @IBAction func submitBtnClicked(_ sender: Any) {
        
        if !enterQtytf.validate(for: .quantity) {
            showAlert1(title: AlertConstants.Error, message: "Please enter a valid quantity (numbers only).")
            return
        }
        let quantTotal = Int(self.enterQtytf.text ?? "0") ?? 0
        guard let prodId = prodId else { return }

        let req = CartRequest(product_id: prodId, quantity: quantTotal)
        cartViewModel.addtoCart(cartreq: req)

        delegate?.quantityAdded()
        dismiss(animated: true)
    }
    
    func addDismissGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissPopup))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissPopup() {
        dismiss(animated: true)
    }
      
    }
    

