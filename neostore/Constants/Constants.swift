//
//  Constants.swift
//  neostore
//
//  Created by Neosoft on 30/10/24.
//

import Foundation

struct Constants{
    
    //MARK: - Icons
    static let Usernameicon = "username_icon"
    static let PasswordIcon = "password_icon"
    static let EmailIcon = "email_icon"
    static let PhoneIcon = "cellphone_icon"
    static let Male = "M"
    static let Female = "F"
    static let CheckedIcon = "checked_icon"
    static let UncheckedIcon = "unchecke_icon"
    static let SelectedRadioButton = "chky"
    static let UnselectedRadioButton = "chkn"
    static let menu_icon = "menu_icon"
    static let magnifyingglass = "magnifyingglass"
    static let delete = "delete"
    static let star_check = "star_check"
    static let star_uncheck = "star_unchek"
}
    //MARK: - Location
    
struct locationsConstants {
  
    static let cities = [
        ("Bangalore", 12.9716, 77.5946),
        ("Hyderabad", 17.3850, 78.4867),
        ("Ahmedabad", 23.0225, 72.5714),
        ("Kolkata", 22.5726, 88.3639),
        ("Lucknow", 26.8467, 80.9462),
        ("Jaipur", 26.9124, 75.7873)
    ]
}
    //MARK: - Storyboard Names and View Controller ID
    
struct SbConstants{
    static let Main = "Main"
    static let ForgetPasswordViewController = "ForgetPasswordViewController"
    static let RegisterViewController = "RegisterViewController"
    static let HomeScreen = "HomeScreen"
    static let ProductViewController = "ProductViewController"
    static let Cart = "Cart"
    static let CartViewController = "CartViewController"
    static let MyAccountViewController = "MyAccountViewController"
    static let StoreLocatorViewController = "StoreLocatorViewController"
    static let MyOrdersViewController = "MyOrdersViewController"
    static let ProductDetailsViewController = "ProductDetailsViewController"
    static let AddressListViewController = "AddressListViewController"
    static let ResetPasswordViewController = "ResetPasswordViewController"
    static let EditProfileViewController = "EditProfileViewController"
}

struct EventConstants {
    static let Loading = "Loading....."
    static let StoppedLoading = "Stopped loading..."
    static let Error = "Error"
    static let DataLoaded = "Data Loaded"
    static let ErrorOccured = "Error occured"
}

struct AlertConstants {
    static let Success = "Success"
    static let Error = "Error"
    static let RegistrationSuccess = "Registration successful!"
    static let RegistrationFail = "Registration failed:"
    static let ValidationError = "Validation Error"
    static let OK = "OK"
}

struct NavigationTitleConst {
    static let Register = "Register"
    static let Error = "Error"
    static let Table = "Table"
    static let Chair = "Chair"
    static let Sofa = "Sofa"
    static let Cupboard = "Cupboard"
    static let ResetPassword = "Reset Password"
    static let MyAccount = "My Account"
    static let EditProfile = "Edit Profile"
    static let MyOrders = "My Orders"
    static let StoreLocator = "Store Locator"
}

struct CellConst {
    static let HomeCollectionViewCell = "HomeCollectionViewCell"
    static let SlideTableViewCell = "SlideTableViewCell"
    static let ProductsTableViewCell = "ProductsTableViewCell"
    static let CartTableViewCell = "CartTableViewCell"
    static let FinalAmtTableViewCell = "FinalAmtTableViewCell"
    static let cell = "cell"
    static let OrderDetailsTableViewCell = "OrderDetailsTableViewCell"
    static let MyOrdersTableViewCell = "MyOrdersTableViewCell"
    static let locationCell = "locationCell"
    static let storePin = "storePin"
}

struct UserDefaultKeyConst {
    static let username = "username"
    static let fullname = "fullname"
    static let profileImage = "profileImage"
    static let password = "password"
    static let Address = "Address"
    static let CartAmt = "CartAmt"
}

