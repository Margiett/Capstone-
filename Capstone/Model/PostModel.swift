//
//  PostModel.swift
//  Capstone
//
//  Created by Margiett Gil on 6/3/20.
//  Copyright © 2020 Margiett Gil. All rights reserved.
//

import Foundation
import Firebase

struct Post {
    let imageURL: String
  //  let datePosted: Timestamp
    let caption: String
    let userName: String
    let userId: String
    let postID: String 
    
}

extension Post {
    init(_ dictionary: [String: Any]) {
        self.imageURL = dictionary["imageURL"] as? String ?? "no image"
       // self.datePosted = dictionary["datePosted"] as? Timestamp ?? Timestamp(date: Date())
        self.caption = dictionary["caption"] as? String ?? "no caption"
        self.userName = dictionary["userName"] as? String ?? "no user name"
        self.userId = dictionary["userId"] as? String ?? "no user ID"
        self.postID = dictionary["postID"] as? String ?? "no post id"
        
    }
}

