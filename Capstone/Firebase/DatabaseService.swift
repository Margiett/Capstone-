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
    static let commentCollection = "comments"
    static let favoriteCollection = "favorites"
    
    // reference to firebase firestore database
    private let db = Firestore.firestore()
    
     // private init() {}
    static let shared = DatabaseService()
    
    
    //Creating the user(dog owner)
    public func createUser(user: UserModel, authDataResult: AuthDataResult, completion: @escaping (Result<Bool, Error>) -> ()) {
        
        guard let email = authDataResult.user.email else {return}
        
        db.collection(DatabaseService.userCollection).document(authDataResult.user.uid).setData(["name": user.name, "email": email, "userId": authDataResult.user.uid, "breed": user.breed, "dogName": user.dogName,"age": user.age, "state": user.state]) { (error) in
           
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
        
    }
    func updateUser(name: String, breed: String, size: String, age: Int, photo: String, completion: @escaping (Result<Bool, Error>) -> ()) {
        guard let user = Auth.auth().currentUser else {return}
        db.collection(DatabaseService.userCollection).document(user.uid).updateData(["name": name, "breed": breed, "size": size, "age": age, "photo": photo]) { (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
    
   public func addToFavorites
    
    
}
