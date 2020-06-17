//
//  CommentModel.swift
//  Capstone
//
//  Created by Margiett Gil on 6/2/20.
//  Copyright © 2020 Margiett Gil. All rights reserved.
//

import Foundation
import Firebase

struct Comment {
    let commentDate: Timestamp
    let commentedBy: String
    let postId: String
    let postName: String
    let text: String
    
}

extension Comment {
    init(_ dictionary: [String: Any]) {
       self.commentDate = dictionary["commentDate"] as? Timestamp ?? Timestamp(date: Date())
        self.commentedBy = dictionary["commentedBy"] as? String ?? "N/A"
        self.postId = dictionary["itemId"] as? String ?? "N/A"
        self.postName = dictionary["itemName"] as? String ?? "N/A"
        self.text = dictionary["text"] as? String ?? "text"
        
    }
}
