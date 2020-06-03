//
//  Favorite.swift
//  Capstone
//
//  Created by Margiett Gil on 6/2/20.
//  Copyright © 2020 Margiett Gil. All rights reserved.
//

import Foundation
import Firebase

struct Favorite {
    let iD: String
    let photoURL: String?
   // let favoritedDate: Timestamp
    let post: String
    let userId: String
}

extension Favorite {
    init(_ dictionary: [String: Any]) {
        self.iD = dictionary["iD"] as? String ?? "no iD"
        self.photoURL = dictionary["photoURL"] as? String ?? "no photo"
        //self.favoritedDate = dictionary["favoritedDate"] as? Timestamp,
        self.post = dictionary["post"] as? String ?? "no post"
        self.userId = dictionary["userId"] as? String ?? "no userId"
        
    }
}
