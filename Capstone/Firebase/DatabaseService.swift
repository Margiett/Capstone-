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
    // this is updating user
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
    
    // this is adding to favorites
    public func addToFaves(post: Post, completion: @escaping (Result<Bool, Error>) -> ()) {
        guard let user = Auth.auth().currentUser else { return }
        db.collection(DatabaseService.userCollection).document(user.uid).collection(DatabaseService.favoriteCollection).document(post.postID).setData(["imageURL": post.imageURL,"datePosted": Timestamp(date: Date()), "caption": post.caption,"userNAme": post.userName, "userId": post.userId, "postID": post.postID ]) { (error) in
            
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
    
    // this is removing post from favorite
    public func removeFromFavorites(post: Post,completion: @escaping (Result<Bool, Error>) -> ()) {
        guard let user = Auth.auth().currentUser else { return }
        db.collection(DatabaseService.userCollection).document(user.uid).collection(DatabaseService.favoriteCollection).document(post.postID).delete { (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
        }
    }
    // this is checking if the post favorite
    public func isPostFavorited(post: Post, completion: @escaping (Result<Bool, Error>) -> ()) {
        guard let user = Auth.auth().currentUser else { return }
        db.collection(DatabaseService.userCollection).document(user.uid).collection(DatabaseService.favoriteCollection).whereField("postId", isEqualTo: post.postID).getDocuments { (snapshot, error) in
            if let error = error {
                completion(.failure(error))
            } else if let snapshot = snapshot {
                let count = snapshot.documents.count
                
                if count > 0 {
                    completion(.success(true))
                } else {
                    completion(.success(false))
                }
            }
        }
    }
    
    
}
