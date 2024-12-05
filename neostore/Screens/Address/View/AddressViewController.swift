//
//  AddressViewController.swift
//  neostore
//
//  Created by Neosoft on 14/11/24.
//

import UIKit

class AddressViewController: UIViewController {
    @IBOutlet weak var addresstf: UITextField!
    
    @IBOutlet weak var landmarktf: UITextField!
    
    @IBOutlet weak var citytf: UITextField!
    
    @IBOutlet weak var statetf: UITextField!
    
    @IBOutlet weak var countrytf: UITextField!
    
    @IBOutlet weak var saveAddressbtn: UIButton!
    
    @IBOutlet weak var zipcodetf: UITextField!
    var AddressArr: [String] {
        get {
            return UserDefaults.standard.stringArray(forKey: UserDefaultKeyConst.Address) ?? []
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultKeyConst.Address)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(AddressArr)
        
    }
     
    private func validateFields() -> Bool {
        return addresstf.validate(for: .address) &&
               landmarktf.validate(for: .landmark) &&
               citytf.validate(for: .city) &&
               statetf.validate(for: .state) &&
               zipcodetf.validate(for: .zipcode) &&
               countrytf.validate(for: .country)
    }


    
    @IBAction func saveAddressBtnClicked(_ sender: Any) {
        guard validateFields() else {
            showAlert1(title: AlertConstants.ValidationError, message: "Please fill out all fields correctly.")
            return
        }
        
        let address = "\(addresstf.text ?? "")" +
                      " \(landmarktf.text ?? "Arjunwadi")" +
                      " \(citytf.text ?? "Navi Mumbai")" +
                      " \(statetf.text ?? "Maharashtra")" +
                      " \(countrytf.text ?? "Bharat")"
        
        AddressArr.append(address)
        
        navigateToScreen(storyboardName: SbConstants.Cart, viewControllerID: SbConstants.AddressListViewController)
    }
    }

