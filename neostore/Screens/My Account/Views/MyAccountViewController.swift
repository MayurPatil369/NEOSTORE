//
//  MyAccountViewController.swift
//  neostore
//
//  Created by Neosoft on 19/11/24.
//

import UIKit

class MyAccountViewController: UIViewController {

    @IBOutlet weak var profileImg: UIImageView!
    
    @IBOutlet weak var firstNametf: UITextField!
    
    @IBOutlet weak var lastNametf: UITextField!
    
    @IBOutlet weak var emailtf: UITextField!
    
    @IBOutlet weak var phoneNumbertf: UITextField!
    
    @IBOutlet weak var dobtf: UITextField!
    
    @IBOutlet weak var editProfileBtn: UIButton!
    
    @IBOutlet weak var resetPasswordBtn: UIButton!
    
    
    var viewmodel = UserDetailsViewModel()
    var editviewmodel = EditProfileViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = NavigationTitleConst.MyAccount
        setupdata()
        setUI()
        viewmodel.getDetails(dataTab: EmptyRequest())
        
    }
    
    func setUI(){
        profileImg.layer.cornerRadius = profileImg.frame.width / 2
        profileImg.layer.masksToBounds = true
        profileImg.layer.borderColor = UIColor.gray.cgColor
        profileImg.layer.borderWidth = 1.0
        
        firstNametf.setIcon(UIImage(named: Constants.Usernameicon) ?? UIImage())
        lastNametf.setIcon(UIImage(named: Constants.Usernameicon) ?? UIImage())
        emailtf.setIcon(UIImage(named: Constants.EmailIcon) ?? UIImage())
        phoneNumbertf.setIcon(UIImage(named: Constants.PhoneIcon) ?? UIImage())
        dobtf.setIcon(UIImage(named: Constants.Usernameicon) ?? UIImage())
        
        firstNametf.setPlaceholder(color: .white)
        lastNametf.setPlaceholder(color: .white)
        emailtf.setPlaceholder(color: .white)
        phoneNumbertf.setPlaceholder(color: .white)
        dobtf.setPlaceholder(color: .white)
        
        firstNametf.setBorder(color: .white, width: 1.5)
        lastNametf.setBorder(color: .white, width: 1.5)
        emailtf.setBorder(color: .white, width: 1.5)
        phoneNumbertf.setBorder(color: .white, width: 1.5)
        dobtf.setBorder(color: .white, width: 1.5)
    }
    
   
    func setupdata(){
        viewmodel.eventHandler = {
            [weak self] event in
            DispatchQueue.main.async {
                guard let self = self else {return}
                
                switch event{
                case .loading:
                    print(EventConstants.Loading)
                case .dataLoaded:
                    print(EventConstants.DataLoaded)
                    self.setUpFields()
                case .stopLoading:
                    print(EventConstants.StoppedLoading)
                case .error(let error):
                    print(error ?? EventConstants.ErrorOccured)
                }
            }
        }
    }
    
    func setUpFields(){
        guard let user = viewmodel.details?.user_data else {return}
        firstNametf.text = user.first_name
        lastNametf.text = user.last_name
        emailtf.text = user.email
        phoneNumbertf.text = user.phone_no
        dobtf.text = user.dob
        
        if let imageData = UserDefaults.standard.data(forKey: UserDefaultKeyConst.profileImage),
           let image = UIImage(data: imageData) {
            profileImg.image = image
        } else {
            profileImg.image = UIImage(named: Constants.SelectedRadioButton)
        }
    }

    @IBAction func resetPasswordBtnClicked(_ sender: Any) {
        navigateToScreen(storyboardName: SbConstants.Cart, viewControllerID: SbConstants.ResetPasswordViewController)
    }
    
    @IBAction func editProfileBtnClicked(_ sender: UIButton) {
        
        guard let editProfileVC = storyboard?.instantiateViewController(withIdentifier: SbConstants.EditProfileViewController) as? EditProfileViewController else {
            return
        }
        
        editProfileVC.initialFirstName = firstNametf.text
        editProfileVC.initialLastName = lastNametf.text
        editProfileVC.initialEmail = emailtf.text
        editProfileVC.initialPhoneNumber = phoneNumbertf.text
        editProfileVC.initialDOB = dobtf.text
        
        navigationController?.pushViewController(editProfileVC, animated: true)
    }
}
