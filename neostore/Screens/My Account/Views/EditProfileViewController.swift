//
//  EditProfileViewController.swift
//  neostore
//
//  Created by Neosoft on 19/11/24.
//

import UIKit

class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var firstName: UITextField!
    
    @IBOutlet weak var lastName: UITextField!
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var phoneNumber: UITextField!
    
    @IBOutlet weak var dateOfBirth: UITextField!
    
    @IBOutlet weak var profileImg: UIImageView!
    
    var initialFirstName: String?
    var initialLastName: String?
    var initialEmail: String?
    var initialPhoneNumber: String?
    var initialDOB: String?

    var viewmodel = EditProfileViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NavigationTitleConst.EditProfile
        setUI()
        setupUI()
        hidekeyboard()
        setTextFieldDelegate()
    }
    
    private func setupUI() {
        profileImg.layer.cornerRadius = profileImg.frame.width / 2
        profileImg.layer.masksToBounds = true
        profileImg.layer.borderColor = UIColor.gray.cgColor
        profileImg.layer.borderWidth = 1.0

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectProfileImage))
        profileImg.isUserInteractionEnabled = true
        profileImg.addGestureRecognizer(tapGesture)
        
        firstName.text = initialFirstName
        lastName.text = initialLastName
        email.text = initialEmail
        phoneNumber.text = initialPhoneNumber
        dateOfBirth.text = initialDOB
    }
    
    func setUI(){
        firstName.setIcon(UIImage(named: Constants.Usernameicon) ?? UIImage())
        lastName.setIcon(UIImage(named: Constants.Usernameicon) ?? UIImage())
        email.setIcon(UIImage(named: Constants.EmailIcon) ?? UIImage())
        phoneNumber.setIcon(UIImage(named: Constants.PhoneIcon) ?? UIImage())
        dateOfBirth.setIcon(UIImage(named: Constants.Usernameicon) ?? UIImage())
        
        firstName.setPlaceholder(color: .white)
        lastName.setPlaceholder(color: .white)
        email.setPlaceholder(color: .white)
        phoneNumber.setPlaceholder(color: .white)
        dateOfBirth.setPlaceholder(color: .white)
        
        firstName.setBorder(color: .white, width: 1.5)
        lastName.setBorder(color: .white, width: 1.5)
        email.setBorder(color: .white, width: 1.5)
        phoneNumber.setBorder(color: .white, width: 1.5)
        dateOfBirth.setBorder(color: .white, width: 1.5)
        
    }
    
    @objc private func selectProfileImage() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true)
    }

    @IBAction func submitBtnClicked(_ sender: Any) {
        guard let firstName = firstName.text, !firstName.isEmpty,
              let lastName = lastName.text, !lastName.isEmpty,
              let email = email.text, !email.isEmpty,
              let dob = dateOfBirth.text, !dob.isEmpty,
              let phoneNo = phoneNumber.text, !phoneNo.isEmpty else {
            showAlert(title: "Error", message: "All Fields Are Required")
            return
        }
    
        var base64ProfilePic = ""
        if let imageData = profileImg.image?.jpegData(compressionQuality: 0.8) {
            base64ProfilePic = imageData.base64EncodedString()
        } else {
            print("No image to encode")
        }

        let requestModel = EditRequest(
            first_name: firstName,
            last_name: lastName,
            email: email,
            dob: dob,
            profile_pic: base64ProfilePic,
            phone_no: phoneNo
        )
        
        viewmodel.editRequest(logs: requestModel) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self?.showAlert(title: AlertConstants.Success, message: response.message)
                case .failure(_):
                    self?.navigateToScreen(storyboardName: SbConstants.HomeScreen, viewControllerID: SbConstants.HomeScreen)
                }
            }
        }
    }
    
    @IBAction func profileUpdateBtnClicked(_ sender: Any) {
        presentImagePickerActionSheet()
    }
    

       private func showAlert(title: String, message: String) {
           let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "OK", style: .default))
           present(alert, animated: true)
       }
    
    func presentImagePickerActionSheet() {
        let actionSheet = UIAlertController(title: "Choose Profile Picture", message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { _ in
            self.openPhotoLibrary()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = true
            present(imagePicker, animated: true, completion: nil)
        } else {
            print("Camera not available")
        }
    }

    func openPhotoLibrary() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = true
            present(imagePicker, animated: true, completion: nil)
        } else {
            print("Photo Library not available")
        }
    }
    
    // UIImagePickerControllerDelegate Method
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[.editedImage] as? UIImage {
            profileImg.image = editedImage
            saveImageToUserDefaults(image: editedImage, forKey: UserDefaultKeyConst.profileImage)
        } else if let originalImage = info[.originalImage] as? UIImage {
            profileImg.image = originalImage
            saveImageToUserDefaults(image: originalImage, forKey: UserDefaultKeyConst.profileImage)
        }
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func saveImageToUserDefaults(image: UIImage, forKey key: String) {
        if let imageData = image.jpegData(compressionQuality: 1.0) {
            UserDefaults.standard.set(imageData, forKey: key)
        } else {
            print("Error: Unable to convert image to data")
        }
    }

}
