//
//  ShareViewController.swift
//  Capstone
//
//  Created by Margiett Gil on 6/18/20.
//  Copyright © 2020 Margiett Gil. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class ShareViewController: UIViewController {
    
    @IBOutlet weak var writeCaptionText: UITextField!
    @IBOutlet weak var uploadedPhoto: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    
    private var selectedImage: UIImage
    private let db = DatabaseService()
    private let storageService = StorageService()
    private let fireStore = Firestore.firestore()
    
    init?(coder: NSCoder, selectedImage: UIImage) {
        self.selectedImage = selectedImage
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("ther coder has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        uploadedPhoto.image = selectedImage

    }
    
    @IBAction func shareButtonPressed(_ sender: UIBarButtonItem) {
        
        guard let caption = writeCaptionText.text, !caption.isEmpty else {
            captionLabel.textColor = .red
            captionLabel.text = "A caption is required in order to post"
            return
        }
        
        let reSizedImage = UIImage.resizeImage(originalImage: selectedImage, rect: uploadedPhoto.bounds)
        
        db.cre
    }
    


}
