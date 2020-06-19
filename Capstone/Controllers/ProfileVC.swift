//
//  ProfileVC.swift
//  Capstone
//
//  Created by Margiett Gil on 6/11/20.
//  Copyright © 2020 Margiett Gil. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import Kingfisher

// need to figure out, and one side of the segmented controll can be a collectionviw and the other side a regular view
enum ViewState {
    case myPost
    case myProfile
}
class ProfileVC: UIViewController {
    
    var editState = 0
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var mainProfilePic: UIImageView!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var secondDetailLabel: UILabel!
    @IBOutlet weak var playDateButton: UIButton!
    @IBOutlet weak var friendRequestButton: UIButton!
    @IBOutlet weak var aboutMeLabel: UILabel!
    @IBOutlet weak var firstMainPic: UIImageView!
    @IBOutlet weak var secondMainPic: UIImageView!
    @IBOutlet weak var thirdMainPic: UIImageView!
    // this is the editbuttong that would show when user wants to edit profile
    @IBOutlet weak var editProfile: UIButton!
    
    // this buttons and textfields will only show when user is editing profile
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var editDetailNameTextField: UITextField!
    @IBOutlet weak var editLocationTextField: UITextField!
    @IBOutlet weak var editAboutMeTextField: UITextField!
    @IBOutlet weak var mainProfilePicEdit: UIButton!
    @IBOutlet weak var firstPicEditbutton: UIButton!
    @IBOutlet weak var secondPicEditButton: UIButton!
    @IBOutlet weak var thirdPicEditButton: UIButton!
    
    
    private lazy var imagePickerController: UIImagePickerController = {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        return imagePicker
    }()
    
    private var selectedImage: UIImage? {
        didSet {
            mainProfilePic.image = selectedImage
        }
    }
    private var selectedImageFirst: UIImage? {
        didSet {
            firstMainPic.image = selectedImageFirst
        }
    }
    
    private var selectedImageTwo: UIImage? {
        didSet {
            firstMainPic.image = selectedImageTwo
        }
    }
    
    private var selectedImageThree: UIImage? {
        didSet {
            secondMainPic.image = selectedImageThree
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        editStateButton()

        
    }
    // This is making sure that the textfiles and buttons are hidden or showing when the user wants to edit there profile
    func editStateButton() {
        if editState == 0 {
            editProfile.isHidden = false
            
            // this would be hidden when the user has not pressed the edit button
            cancelButton.isHidden = true
            saveButton.isHidden = true
            editDetailNameTextField.isHidden = true
            editAboutMeTextField.isHidden = true
            editLocationTextField.isHidden = true
            mainProfilePic.isHidden = true
            firstMainPic.isHidden = true
            secondMainPic.isHidden = true
            thirdMainPic.isHidden = true
            
        }
    }
    @IBAction func editProfilButtonPressed(_ sender: UIButton) {
        editState = 1
        saveButton.isHidden = false
        cancelButton.isHidden = false
        editLocationTextField.isHidden = false
        editAboutMeTextField.isHidden = false
        editDetailNameTextField.isHidden = false
        
        // this would be hidden when the edit button is pressed
        playDateButton.isHidden = true
        friendRequestButton.isHidden = true
        aboutMeLabel.alpha = 0.0
        detailLabel.alpha = 0.0
        secondDetailLabel.alpha = 0.0
        
    }
    
    @IBAction func savedButtonPressed(_ sender: UIButton) {
        editState = 0
        guard let detail = editDetailNameTextField.text, !detail.isEmpty else { return }
        
        guard let detailLocation = editLocationTextField.text, !detailLocation.isEmpty,
            let selectedImageOne = selectedImageFirst,
            let selectedImageTwo = selectedImageTwo,
            let selectedImageThird = selectedImageThree else { return }
        
        guard let aboutME = editAboutMeTextField.text, !aboutME.isEmpty, let selectedImage = selectedImage else { return }
        
        guard let user = Auth.auth().currentUser else { return }
        
        let resizedImage = UIImage.resizeImage(originalImage: selectedImage, rect: mainProfilePic.bounds)
        
        StorageService.shared.uploadPhoto(userId: user.uid, image: resizedImage) { [weak self] (result) in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Error uploading photo", message: "\(error.localizedDescription)")
                }
            case .success(let url):
                break
                
            }
        }
     
        }
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        editState = 0
        editProfile.isHidden = false
        cancelButton.isHidden = true
        saveButton.isHidden = true
        
        editDetailNameTextField.isHidden = true
        editLocationTextField.isHidden = true
        editAboutMeTextField.isHidden = true
        
        detailLabel.alpha = 1.0
        secondDetailLabel.alpha = 1.0
        aboutMeLabel.alpha = 1.0
    }
    
    
    
    
    }
 

extension ProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
            else {
                return
        }
        selectedImage = image
        dismiss(animated: true)
    }
}
