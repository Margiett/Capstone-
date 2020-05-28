//
//  FirebaseAuthManager.swift
//  Capstone
//
//  Created by Margiett Gil on 5/28/20.
//  Copyright © 2020 Margiett Gil. All rights reserved.
//

import UIKit
import FirebaseAuth

class FirebaseAuthManager{
   public func createNewUser(email: String, password: String, completion: @escaping (Result<AuthDataResult, Error>) -> ()) {
           Auth.auth().createUser(withEmail: email, password: password) { (authDataResult, error) in
               if let error = error {
                   completion(.failure(error))
               } else if let authDataResult = authDataResult {
                   completion(.success(authDataResult))
               }
           }
       }
       public func signExisitingUser(email: String, password: String, completion: @escaping (Result<AuthDataResult, Error>) -> ()) {
           Auth.auth().signIn(withEmail: email, password: password) { (authDataResult, error) in
               if let error = error {
                   completion(.failure(error))
               } else if let authDataResult = authDataResult {
                   completion(.success(authDataResult))
               }
           }
       }
}
