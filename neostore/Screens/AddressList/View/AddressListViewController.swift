//
//  AddressListViewController.swift
//  neostore
//
//  Created by Neosoft on 14/11/24.
//

import UIKit

class AddressListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{

    
    var arr = UserDefaults.standard.array(forKey: "Address") ?? []
    
    var finalAddress : String?
    var selectedIndex: IndexPath?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        let nib = UINib(nibName: "AddressListTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "AddressListTableViewCell")
        
        navigationBarItems()
    }
    
    func navigationBarItems() {
        
        let addAddressBtn = UIBarButtonItem(image: UIImage(systemName: "plus"),
                                            style: .plain,
                                            target: self,
                                            action: #selector(addAddressActionMethod))
        self.title = "Address List"
        navigationItem.rightBarButtonItems = [addAddressBtn]
    }
    
    @objc func addAddressActionMethod() {
        //Navigation to Add Address
        navigateToScreen(storyboardName: "Cart", viewControllerID: "AddressViewController")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddressListTableViewCell") as! AddressListTableViewCell
        
        cell.fullname.text = UserDefaults.standard.string(forKey: "fullname")
        cell.address.text = arr[indexPath.row] as? String
        
        if indexPath == selectedIndex {
            cell.selectedImg.image = UIImage(systemName: "circle.inset.filled")
            cell.isCheck = true
        } else {
            cell.selectedImg.image = UIImage(systemName: "circle")
            cell.isCheck = false
        }
     
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let previousIndex = selectedIndex, let previousCell = tableView.cellForRow(at: previousIndex) as? AddressListTableViewCell {
            previousCell.selectedImg.image = UIImage(systemName: "circle")
            previousCell.isCheck = false
        }
        
        selectedIndex = indexPath
        if let cell = tableView.cellForRow(at: indexPath) as? AddressListTableViewCell {
            cell.selectedImg.image = UIImage(systemName: "circle.inset.filled")
            cell.isCheck = true
        }
        
        finalAddress = arr[indexPath.row] as? String
        print(finalAddress ?? "")
    }
    

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            let delete = UIContextualAction(style: .destructive, title: ""){ (action , view , success ) in
                self.arr.remove(at: indexPath.row)
                var addressArray = UserDefaults.standard.array(forKey: "Address")
                addressArray?.remove(at: indexPath.row)
                UserDefaults.standard.set(addressArray, forKey: "Address")
                self.tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
                self.tableView.reloadData()
            }
            let theImage: UIImage? = UIImage(named:"delete")?.withRenderingMode(.alwaysOriginal)
            delete.backgroundColor = UIColor.white
            delete.image = theImage

            let swipeActions = UISwipeActionsConfiguration(actions: [delete])
            return swipeActions
            }

    @IBAction func AddaddressBtnTapped(_ sender: Any) {
        navigateToScreen(storyboardName: "Cart", viewControllerID: "AddressViewController")
    }
    @IBAction func placeOrderBtnClicked(_ sender: Any) {
        let logs = OrderRequest(address: finalAddress ??  "")
        print(finalAddress ?? "")
        self.orderRequest(logs: logs)
        UserDefaults.standard.set(0, forKey: "CartTotal")
        UserDefaults.standard.set(0, forKey: "CartAmt")
    }
    
    
}

