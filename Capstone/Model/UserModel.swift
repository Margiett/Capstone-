//
//  UserModel.swift
//  Capstone
//
//  Created by Margiett Gil on 5/28/20.
//  Copyright © 2020 Margiett Gil. All rights reserved.
//

import Foundation

struct UserModel: Codable {
   
    let name: String
    let userId: String
    let breed: String
    let dogName: String
    let age: Int
    let state: String
    
}

extension UserModel {
    init(_ dictionary: [String: Any]) {
        self.name = dictionary["name"] as? String ?? "no owner name"
        self.userId = dictionary["userId"] as? String ?? UUID().uuidString
        self.breed = dictionary["breed"] as? String ?? "breed"
        self.dogName = dictionary["dogName"] as? String ?? "dogName"
        self.age = dictionary["age"] as? Int ?? 0
        self.state = dictionary["state"] as? String ?? "no state"
    }
}


