//
//  SlideViewControllerExtension.swift
//  neostore
//
//  Created by Neosoft on 11/11/24.
//

import Foundation
import UIKit

extension SlideViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MenuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellConst.SlideTableViewCell, for: indexPath) as! SlideTableViewCell
        cell.MenuTableImgView.image = UIImage(named: MenuImgItems[indexPath.row])
        cell.MenuTableTitleText.text = MenuItems[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            navigateToScreen(storyboardName: SbConstants.Cart, viewControllerID: SbConstants.CartViewController)
        }
        else if indexPath.row == 1 {
            navigateToScreen(storyboardName: SbConstants.HomeScreen, viewControllerID: SbConstants.ProductViewController, prodCatId: 1)
        }
        else if indexPath.row == 2 {
            navigateToScreen(storyboardName: SbConstants.HomeScreen, viewControllerID: SbConstants.ProductViewController, prodCatId: 3)
        }
        else if indexPath.row == 3 {
            navigateToScreen(storyboardName: SbConstants.HomeScreen, viewControllerID: SbConstants.ProductViewController, prodCatId: 2)
        }
        else if indexPath.row == 4 {
            navigateToScreen(storyboardName: SbConstants.HomeScreen, viewControllerID: SbConstants.ProductViewController, prodCatId: 4)
        }
        else if indexPath.row == 5 {
            navigateToScreen(storyboardName: SbConstants.Cart, viewControllerID: SbConstants.MyAccountViewController)
        }
        else if indexPath.row == 6 {
            navigateToScreen(storyboardName: SbConstants.Cart, viewControllerID: SbConstants.StoreLocatorViewController)
        }
        else if indexPath.row == 7 {
            navigateToScreen(storyboardName: SbConstants.Cart, viewControllerID: SbConstants.MyOrdersViewController)
        }
        else if indexPath.row == 8 {
            UserDefaults.standard.removeObject(forKey: UserDefaultKeyConst.username)
            UserDefaults.standard.removeObject(forKey: UserDefaultKeyConst.password)
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
}
