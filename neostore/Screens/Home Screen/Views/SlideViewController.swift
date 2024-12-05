//
//  SlideViewController.swift
//  neostore
//
//  Created by Neosoft on 11/11/24.
//


import UIKit

protocol SideViewControllerDelegate {
    func hideSideMenu()
}
protocol SideViewDelegate{
    func accountUpdate()
}

class SlideViewController: UIViewController {
    
    @IBOutlet weak var MenuUserName: UILabel!
    
    @IBOutlet weak var MenuEmail: UILabel!
    
    @IBOutlet weak var BackBtn: UIButton!
    
    
    
    
    var MenuItems = ["My Cart","Tables","Sofas","Chairs","Cupboards","My Account","Store Locator","My Orders","Logout"]
    var MenuImgItems = ["shopping_cart","tables_icon","sofa_icon","chair_icon","cupboard_icon","username_icon","storelocator_icon","myorders_icon","logout_icon"]
    
    
    
    @IBOutlet weak var MenuProfileImg: UIImageView!
    
    @IBOutlet weak var MenuTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        roundProfileImg()
        MenuTableView.delegate = self
        MenuTableView.dataSource = self
        _ = UserDefaults.standard.string(forKey: UserDefaultKeyConst.username)
        self.MenuUserName.text = UserDefaults.standard.string(forKey: UserDefaultKeyConst.fullname)
        self.MenuEmail.text = UserDefaults.standard.string(forKey: UserDefaultKeyConst.username)

        
        let nib = UINib(nibName: CellConst.SlideTableViewCell, bundle: nil)
        MenuTableView.register(nib, forCellReuseIdentifier: CellConst.SlideTableViewCell)
        self.MenuTableView.allowsSelection = true
        
        if let imageData = UserDefaults.standard.data(forKey: UserDefaultKeyConst.profileImage),
           let image = UIImage(data: imageData) {
            MenuProfileImg.image = image
        } 
        
    }
    
    func roundProfileImg(){
        MenuProfileImg.layer.cornerRadius = MenuProfileImg.frame.width / 2
        MenuProfileImg.layer.masksToBounds = true
        MenuProfileImg.layer.borderColor = UIColor.gray.cgColor
        MenuProfileImg.layer.borderWidth = 1.0
    }

}

