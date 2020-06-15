//
//  ProfileVC.swift
//  Capstone
//
//  Created by Margiett Gil on 6/11/20.
//  Copyright © 2020 Margiett Gil. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    
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
    @IBOutlet weak var editProfile: UIButton!
    
    
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

 

}

extension ProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
            else {
                return
        }
        dismiss(animated: true)
    }
}
