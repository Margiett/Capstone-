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
    
    @IBOutlet weak var writeCaptionTextField: UITextField!
    @IBOutlet weak var uploadedPhoto: UIImageView!
    @IBOutlet weak var labelCaption: UILabel!
    
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
    
    @IBAction func sharePostButtonPressed(_ sender: UIBarButtonItem) {
        
        guard let caption = writeCaptionTextField.text, !caption.isEmpty else {
            labelCaption.textColor = .red
            labelCaption.text = "A caption is required in order to post"
            return
        }
        
        let reSizedImage = UIImage.resizeImage(originalImage: selectedImage, rect: uploadedPhoto.bounds)
        
        db.createPost(caption: caption, displayName: displayName, imageURL: imageURL) { [weak self ] (result) in
        
        //createPost(caption: caption, imageURL: imageURL, displayName: displayName) { [weak self] (result) in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Error creating post", message: error.localizedDescription)
                }
            case .success(let postID):
                self?.uploadedPhoto(image: reSizedImage, postID: postID)
            }
        }
    }
    
    private func uploadedPhoto(image: UIImage, postID: String) {
        storageService.uploadPhoto(postId: postID, image: image) {
            [weak self] (result) in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Error", message: "\(error.localizedDescription)")
                }
            case .success(let url):
                self?.updateImageURL(url, postID: postID)
            }
        }
    }
    
    private func updateImageURL(_ url: URL, postID: String) {
        fireStore.collection(DatabaseService.postCollection).document(postID).updateData(["imageURL": url.absoluteURL]) { [weak self](error) in
            if let error = error {
                DispatchQueue.main.async {
                    self?.showAlert(title: "failed to update post image", message: "\(error.localizedDescription)")
                }
            } else {
                print("testing to see if this is working Margiett !!")
                DispatchQueue.main.async {
                    self?.dismiss(animated: true)
                }
            }
        }
        
    }
    
}
