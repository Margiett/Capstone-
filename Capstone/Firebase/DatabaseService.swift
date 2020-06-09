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
    static let postCollection = "post"
    
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
    
    // deleting Post
    public func delete(post: Post, completion: @escaping (Result<Bool, Error>) -> ()) {
        db.collection(DatabaseService.postCollection).document(post.postID).delete { (error) in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(true))
            }
            
            }
    
        
    }
    
    public func postComment(post: Post, comment: String, completion: @escaping (Result<Bool, Error>) -> ()) {
        guard let user = Auth.auth().currentUser, let displayName = user.displayName else {
            print("missing user data")
            return
        }
        
        let docRef = db.collection(DatabaseService.postCollection).document(post.postID).collection(DatabaseService.commentCollection).document()
        
        db.collection(DatabaseService.commentCollection).document(docRef.documentID).setData(["text": comment, "commentDate": Timestamp(date: Date()), "postName": post.userName, "postID": post.postID, "commentedBy": displayName]) { (error) in
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
    
    public func fetchUserPost(userId: String, completion: @escaping (Result<[Post], Error>) -> ()) {
        db.collection(DatabaseService.postCollection).whereField(Constants.postId, isEqualTo: userId).getDocuments { (snapshot, error) in
            if let error = error {
                completion(.failure(error))
            } else if let snapshot = snapshot {
                let posts = snapshot.documents.map {Post ($0.data())}
                completion(.success(posts.sorted(by: {$0.datePosted.seconds > $1.datePosted.seconds })))
            }
        }
    }
    
    public func fetchFavorites(completion: @escaping (Result<[Favorite], Error>) -> ()) {
        guard let user = Auth.auth().currentUser else { return }
        db.collection(DatabaseService.userCollection).document(user.uid).collection(DatabaseService.favoriteCollection).getDocuments { (snapshot, error) in
            if let error = error {
                completion(.failure(error))
            } else if let snapshot = snapshot {
                let favorties = snapshot.documents.compactMap { Favorite($0.data())}
                completion(.success(favorties.sorted(by: {$0.favoritedDate.seconds > $1.favoritedDate.seconds})))
            }
        }
    }
    
    
}

