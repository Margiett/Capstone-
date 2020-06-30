//
//  FeedCell.swift
//  Capstone
//
//  Created by Margiett Gil on 6/4/20.
//  Copyright © 2020 Margiett Gil. All rights reserved.
//

import UIKit
import Kingfisher
import FirebaseAuth

class FeedCell: UICollectionViewCell {
    
    @IBOutlet weak var userProfilePic: UIImageView!
    @IBOutlet weak var username: UILabel!
    
    @IBOutlet weak var postPicture: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var datePostLabel: UILabel!
    @IBOutlet weak var faveButton: UIButton!
    @IBOutlet weak var commentButton: UIButton!
    
    
    private var post: Post!
    
    private var isFavorite = false {
           didSet {
               if isFavorite {
                   faveButton.imageView?.image = UIImage(systemName: "heart.fill")
                   
               } else {
                   faveButton.imageView?.image = UIImage(systemName: "heart")
               }
               
           }
       }
    
    
    
    public func confirgureCell(post: Post) {
       // updateUI()
        
        
        if let user = Auth.auth().currentUser, let displayname = user.displayName {
            userProfilePic.kf.setImage(with: user.photoURL)
            username.text = displayname
        } else {
            userProfilePic.image = UIImage(systemName: "person.fill")
            userProfilePic.image?.withTintColor(#colorLiteral(red: 0, green: 0.7827044129, blue: 0.7580528855, alpha: 1))
            captionLabel.text = post.caption
            datePostLabel.text = post.datePosted.description
            userProfilePic.kf.setImage(with: URL(string: post.imageURL))
            
            
        }
            
            
        }
    
    
    //MARK: this is favorting the post, the heart will be filled when is favorited and it will be empty when is not favorite
    @IBAction func favoriteButtonPressed(_ sender: UIButton) {
        
        if isFavorite {
            DatabaseService().removeFromFavorites(post: post) { [weak self] (result) in
                switch result {
                case .failure(let error):
                    DispatchQueue.main.async {
                        self?.showAlert(title: "Failed to remove favorite", message: error.localizedDescription)
                    }
                case .success:
                    DispatchQueue.main.async {
                        self?.showAlert(title: "Item removed", message: nil)
                        self?.isFavorite = false
                    }
                }
            }
        } else {
            DatabaseService().addToFaves(post: post) { [weak self] (result) in
                switch result {
                case .failure(let error):
                    DispatchQueue.main.async {
                        self?.showAlert(title: "Favoriting error", message: error.localizedDescription)
                    }
                case .success:
                    DispatchQueue.main.async {
                        self?.showAlert(title: "item was favorited", message: "❤️")
                        self?.isFavorite = true
                    }
                }
            }
        }
        
    }
    
    // this is checking is the post is favorited or not 
//    private func updateUI() {
//
//        DatabaseService().isPostFavorited(post: post) { [weak self] (result) in
//            switch result {
//            case .failure(let error):
//                DispatchQueue.main.async {
//                    self?.showAlert(title: "try again", message: error.localizedDescription)
//                }
//            case .success(let success):
//                if success {
//                    self?.isFavorite = true
//                } else {
//                    self?.isFavorite = false
//                }
//            }
//        }
//    }
    
   }

