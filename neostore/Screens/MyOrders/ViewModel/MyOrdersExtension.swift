//
//  MyOrdersExtension.swift
//  neostore
//
//  Created by Neosoft on 28/11/24.
//

import Foundation
import UIKit

extension MyOrdersViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.orderListViewModel.details.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MyOrdersTableView.dequeueReusableCell(withIdentifier: "MyOrdersTableViewCell", for: indexPath) as! MyOrdersTableViewCell
        let od = self.orderListViewModel.details[indexPath.row]
        cell.order = od
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let od = self.orderListViewModel.details[indexPath.row]
        
        let storyboard = UIStoryboard(name: "Cart", bundle: nil)
        let orderDetailsVC = storyboard.instantiateViewController(withIdentifier: "OrderDetailsViewController") as! OrderDetailsViewController
        orderDetailsVC.orderDetailsId = od.id
        self.navigationController?.pushViewController(orderDetailsVC, animated: true)

    }
}
