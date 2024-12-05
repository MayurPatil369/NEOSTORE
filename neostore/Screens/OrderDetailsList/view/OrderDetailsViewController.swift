//
//  OrderDetailsViewController.swift
//  neostore
//
//  Created by Neosoft on 27/11/24.
//

import UIKit

class OrderDetailsViewController: UIViewController {
 
    

    @IBOutlet weak var OrderDetailsTableView: UITableView!
    var orderDetailsId: Int?
    var orderDetailsVM = OrderDetailsVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        OrderDetailsTableView.dataSource = self
        OrderDetailsTableView.delegate = self
        self.navigationItem.title = "OrderId: \(orderDetailsId ?? 0)"
       
        let req = OrderDetailsRequest(order_id: orderDetailsId ?? 0)
        
        let nib = UINib(nibName: CellConst.OrderDetailsTableViewCell, bundle: nil)
        OrderDetailsTableView.register(nib, forCellReuseIdentifier: CellConst.OrderDetailsTableViewCell)
        
        let nib1 = UINib(nibName: CellConst.FinalAmtTableViewCell, bundle: nil)
        OrderDetailsTableView.register(nib1, forCellReuseIdentifier: CellConst.FinalAmtTableViewCell)
        
        initViewModel(req: req, id: orderDetailsId!)
        observeEvent()
        
    }

    func initViewModel(req: OrderDetailsRequest , id: Int){
        orderDetailsVM.getOrderDetails(dataTab: req, id: id)
    }
    func observeEvent(){
        orderDetailsVM.eventHandler = { [weak self] event in
            guard let self else {return}
            
            switch event {
            case .loading:
                print(EventConstants.Loading)
            case .stopLoading:
                print(EventConstants.StoppedLoading)
            case .dataLoaded:
                print(EventConstants.DataLoaded)
                DispatchQueue.main.async {
                    self.OrderDetailsTableView.reloadData()
                    
                }
            case .error(let error):
                print(error ?? "")
            }
        }
    }
}
