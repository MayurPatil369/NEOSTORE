//
//  CartViewController.swift
//  neostore
//
//  Created by Neosoft on 21/11/24.
//

import UIKit

protocol CartViewDelegate {
    func cartAdded(request:EditCartRequest, at indexPath: IndexPath)
}

class CartViewController: UIViewController {

    
    @IBOutlet weak var CartTableView: UITableView!
    
    var product : productDetailsData?
    
    lazy var cartViewModel = ListCartViewModel()
    lazy var deleteCartViewModel = DeleteCartViewModel()
    lazy var editCartViewModel = EditCartViewModel()
    var productQty : Int?
    override func viewDidLoad() {
        super.viewDidLoad()

        configuration()
        
        let nib = UINib(nibName: CellConst.CartTableViewCell, bundle: nil)
        CartTableView.register(nib, forCellReuseIdentifier: CellConst.CartTableViewCell)
        
        let nib2 = UINib(nibName: CellConst.FinalAmtTableViewCell, bundle: nil)
        CartTableView.register(nib2, forCellReuseIdentifier: CellConst.FinalAmtTableViewCell)
    }
    
    func configuration() {


        CartTableView.delegate = self
        CartTableView.dataSource = self
        
        if let product = product {
            print("Product passed to CartViewController: \(product.name ?? "Unknown")")
        } else {
            print("No product passed to CartViewController.")
        }
        
        let req = CartRequest(product_id: product?.id ?? 0, quantity: 0)
        initViewModel(req: req)
        observeEvent()
      
    }
    
    func initViewModel(req: CartRequest){
        cartViewModel.fetchCart(dataTab: req)
    }
    
    func observeEvent(){
        cartViewModel.eventHandler = { [weak self] event in
            guard let self else {return}
            
            switch event {
            case .loading:
                print(EventConstants.Loading)
            case .stopLoading:
                print(EventConstants.StoppedLoading)
            case .dataLoaded:
                print(EventConstants.DataLoaded)
                DispatchQueue.main.async {
                    self.CartTableView.reloadData()
                }
            case .error(let error):
                print(error ?? "")
            }
        }
        
        editCartViewModel.eventHandler = { [weak self] event in
            guard let self else {return}
            
            switch event {
            case .loading:
                print(EventConstants.Loading)
            case .stopLoading:
                print(EventConstants.StoppedLoading)
            case .dataLoaded:
                print(EventConstants.DataLoaded)
                DispatchQueue.main.async {
                    let req = CartRequest(product_id: 1, quantity: 0)
                    self.initViewModel(req: req)

                }
            case .error(let error):
                print(error ?? "")
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let req = CartRequest(product_id: product?.id ?? 0, quantity: 0)
            cartViewModel.fetchCart(dataTab: req)
    }
    override func viewDidDisappear(_ animated: Bool) {
        self.navigationItem.backButtonTitle = ""
    }
    
    func showCart(){
        let sb = UIStoryboard(name: SbConstants.Cart, bundle: nil)
        let cartVC = sb.instantiateViewController(withIdentifier: SbConstants.CartViewController)
        self.navigationController?.pushViewController(cartVC, animated: true)
    }
    
    
    @IBAction func orderNowBtnClicked(_ sender: UIButton) {
        navigateToScreen(storyboardName: SbConstants.Cart, viewControllerID: SbConstants.AddressListViewController)
    }
    
}

extension CartViewController: CartViewDelegate {
    func cartAdded(request: EditCartRequest, at indexPath: IndexPath) {
        self.editCartViewModel.editCart(dataTab: request)
                DispatchQueue.main.async {
            self.CartTableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
}

