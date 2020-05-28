//
//  DatabaseService.swift
//  Capstone
//
//  Created by Margiett Gil on 5/28/20.
//  Copyright © 2020 Margiett Gil. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class DatabaseService {
    static let userCollection = "user"
    
    // reference to firebase firestore database
    private let db = Firestore.firestore()
    
     // private init() {}
    static let shared = DatabaseService()
    
    
    //Creating the user(dog owner)
    public func createUser(user: UserModel, authDataResult: AuthDataResult, completion: @escaping (Result<Bool, Error>) -> ()) {
        
    }
    
    
    
    
}
