//
//  orderDetailsExtension.swift
//  neostore
//
//  Created by Neosoft on 27/11/24.
//

import Foundation
import UIKit

extension OrderDetailsViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let cnt = self.orderDetailsVM.details?.order_details?.count ?? 0
        return cnt+1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cnt = self.orderDetailsVM.details?.order_details?.count ?? 0
        
        if indexPath.row < cnt {
            let cell = OrderDetailsTableView.dequeueReusableCell(withIdentifier: CellConst.OrderDetailsTableViewCell) as! OrderDetailsTableViewCell
            let od = self.orderDetailsVM.details?.order_details?[indexPath.row]
            cell.productName.text = od?.prod_name
            let amount = od?.total
            cell.productCost.text = String(amount!)
            cell.productCategory.text = od?.prod_cat_name
            let qty = od?.quantity
            cell.productQuantity.text = String(qty!)
            if let imageUrlString = od?.prod_image, let url = URL(string: imageUrlString) {
                cell.productImage.loadImage(from: url)
            }

            return cell
        } else if indexPath.row == cnt {
            let cell = OrderDetailsTableView.dequeueReusableCell(withIdentifier: CellConst.FinalAmtTableViewCell) as! FinalAmtTableViewCell
            let total = self.orderDetailsVM.details?.cost
            let totalAmount = "Rs. \(total ?? 22)"
            cell.totalcost.text = String(totalAmount)
            return cell
        }
      return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
