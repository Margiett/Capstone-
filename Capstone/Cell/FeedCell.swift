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
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var datePostLabel: UILabel!
    @IBOutlet weak var commentButton: UIButton!
    
    public func confirgureCell(post: Post) {
        
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
    }
}
