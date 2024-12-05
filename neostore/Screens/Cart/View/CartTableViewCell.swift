//
//  CartTableViewCell.swift
//  neostore
//
//  Created by Neosoft on 21/11/24.
//

import UIKit

class CartTableViewCell: UITableViewCell, UITableViewDelegate, UITableViewDataSource {

    
    var options: [Int] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]
    var isDropdownVisible = false
    
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productDes: UILabel!
    
    @IBOutlet weak var productImg: UIImageView!
    @IBOutlet weak var cartPrice: UILabel!
    @IBOutlet weak var quantityBtn: UIButton!
    
    @IBOutlet weak var dropdowntableview: UITableView!
    
    
    var cartViewDelegate: CartViewDelegate?

    var cartData: ListCartData? {
        didSet{
            cartConfiguration()
        }
    }
    var prodId: Int!
    var prodCost: Int!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupViews()
    }
    
    func setupViews(){
        dropdowntableview.delegate = self
        dropdowntableview.dataSource = self
        dropdowntableview.register(UITableViewCell.self, forCellReuseIdentifier: CellConst.cell)
        dropdowntableview.isHidden = true
    }
    
    func cartConfiguration(){
        let cost = UserDefaults.standard.integer( forKey: "ProdCost \(String(describing: cartData?.product_id))")
        let quant = UserDefaults.standard.integer(forKey: "ProdQuant \(String(describing: cartData?.product_id))")
        prodId = cartData?.product.id
        prodCost = cartData?.product.cost
        productName.text = cartData?.product.name
        productDes.text = cartData?.product.product_category
        if let imgurl = URL(string:cartData?.product.product_images ?? ""){
            productImg.loadImage(from: imgurl)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func selectQtyBtnTapped(_ sender: Any) {
        if self.isDropdownVisible == false {
            self.isDropdownVisible = true
            self.dropdowntableview.heightAnchor.constraint(equalToConstant: self.isDropdownVisible ? CGFloat(self.options.count * 44) : 0).isActive = true
        } else if self.isDropdownVisible == true{
            self.isDropdownVisible = false
        }
        self.dropdowntableview.isHidden = !self.isDropdownVisible
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
            self.dropdowntableview.layer.borderWidth = 1.0
            self.dropdowntableview.layer.borderColor = UIColor.lightGray.cgColor
            
        }
        self.dropdowntableview.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = dropdowntableview.dequeueReusableCell(withIdentifier: CellConst.cell, for: indexPath)
        cell.textLabel?.text = String(options[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        quantityBtn.setTitle(String(options[indexPath.row]), for: .normal)
        let req = EditCartRequest(product_id: self.prodId, quantity: options[indexPath.row])
        UserDefaults.standard.set(options[indexPath.row], forKey: "ProdQuant \(String(describing: self.prodId))" )
        
        if let superview = self.superview as? UITableView, let indexPath = superview.indexPath(for: self) {
            cartViewDelegate?.cartAdded(request: req, at: indexPath)
        }
        dropdowntableview.isHidden = true
        isDropdownVisible = false
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
}
