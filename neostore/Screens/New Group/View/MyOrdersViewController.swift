//
//  MyOrdersViewController.swift
//  neostore
//
//  Created by Neosoft on 28/11/24.
//

import UIKit

class MyOrdersViewController: UIViewController{

    
    
    @IBOutlet weak var MyOrdersTableView: UITableView! {
    didSet {
        MyOrdersTableView.delegate = self
        MyOrdersTableView.dataSource = self
    }
}
    var orderListViewModel = OrderListViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = NavigationTitleConst.MyOrders

        
        let nib = UINib(nibName: CellConst.MyOrdersTableViewCell, bundle: nil)
        MyOrdersTableView.register(nib, forCellReuseIdentifier: CellConst.MyOrdersTableViewCell)
        
        let req = ProdRequest(product_category_id: 1)
        initViewModel(req: req)
        observeEvent()
    }
    func initViewModel(req: ProdRequest){
        orderListViewModel.getOrder(dataTab: req)
    }
    func observeEvent(){
        orderListViewModel.eventHandler = { [weak self] event in
            guard let self else {return}
            
            switch event {
            case .loading:
                print(EventConstants.Loading)
            case .stopLoading:
                print(EventConstants.StoppedLoading)
            case .dataLoaded:
                print(EventConstants.DataLoaded)
                DispatchQueue.main.async {
                    self.MyOrdersTableView.reloadData()
                }
            case .error(let error):
                print(error ?? "")
            }
        }
    }


    
    
    
}
