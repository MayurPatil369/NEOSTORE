//
//  CartExtension.swift
//  neostore
//
//  Created by Neosoft on 21/11/24.
//

import Foundation
import UIKit


extension CartViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cartViewModel.products.count + 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row < self.cartViewModel.products.count {
            let tb = self.cartViewModel.products[indexPath.row]
            let cell = CartTableView.dequeueReusableCell(withIdentifier: CellConst.CartTableViewCell, for: indexPath) as! CartTableViewCell
            
            UserDefaults.standard.set(tb.quantity, forKey: "ProdQuant \(String(describing: tb.product_id))" )
            
            UserDefaults.standard.set(tb.product.cost, forKey: "ProdCost \(String(describing: tb.product_id))")
            cell.cartViewDelegate = self
            let cost = UserDefaults.standard.integer( forKey: "ProdCost \(String(describing: tb.product_id))")
            let quant = UserDefaults.standard.integer(forKey: "ProdQuant \(String(describing: tb.product_id))")
            let totalcost = cost*quant
                        cell.quantityBtn.setTitle(String(quant), for: .normal)
                        cell.cartPrice.text = "Rs. \(totalcost)"
                        cell.cartData = tb
            return cell
        }
        else {
            let cell = CartTableView.dequeueReusableCell(withIdentifier: CellConst.FinalAmtTableViewCell, for: indexPath) as! FinalAmtTableViewCell
            let amt = UserDefaults.standard.integer(forKey: UserDefaultKeyConst.CartAmt)
            if self.cartViewModel.products.count == 0{
                                cell.totalcost.text = "Empty Cart"
                                cell.totallbl.text = "Add Products"
                            } else{
                                cell.totallbl.text = "Total"
                                cell.totalcost.text = "Rs. \(amt)"
                            }
                
                return cell
            }
        }
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            
            if indexPath.row == self.cartViewModel.products.count
            {
                return 120
            }
            return UITableView.automaticDimension
        }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard tableView.cellForRow(at: indexPath) is CartTableViewCell else {
            return nil
        }

        let delete = UIContextualAction(style: .destructive, title: "") { (action, view, success) in
            let item = self.cartViewModel.products[indexPath.row]
            
            let total = UserDefaults.standard.integer(forKey: UserDefaultKeyConst.CartAmt)
            UserDefaults.standard.set(total - (item.product.cost * item.quantity), forKey: UserDefaultKeyConst.CartAmt)
            
            self.deleteCartViewModel.deleteCart(cartreq: DelCartRequest(product_id: item.product_id))
            
            self.cartViewModel.products.remove(at: indexPath.row)
            self.CartTableView.deleteRows(at: [indexPath], with: .automatic)
            
            self.CartTableView.reloadData()
        }

        let theImage: UIImage? = UIImage(named: Constants.delete)?.withRenderingMode(.alwaysOriginal)
        delete.backgroundColor = .white
        delete.image = theImage

        let swipeActions = UISwipeActionsConfiguration(actions: [delete])
        return swipeActions
    }

        
    }
    

