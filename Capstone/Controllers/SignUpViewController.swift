//
//  SignUpViewController.swift
//  Capstone
//
//  Created by Margiett Gil on 5/28/20.
//  Copyright © 2020 Margiett Gil. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {

    @IBOutlet weak var dogName: UITextField!
    @IBOutlet weak var breed: UITextField!
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var ownerName: UITextField!
    @IBOutlet weak var state: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    
    private var authSession = FirebaseAuthManager()
    
    override func viewDidLoad() {
           super.viewDidLoad()

           // Do any additional setup after loading the view.
       }
    
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        guard let email = email.text, !email.isEmpty,
            let password = password.text, !password.isEmpty else {
                self.showAlert(title: "Missing feilds", message: "Please provide an email and password")
                return
        }
        authSession.createNewUser(email: email, password: password) { (result) in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showAlert(title: "Error Signing up", message: "\(error.localizedDescription)")
                }
            case .success:
                DispatchQueue.main.async {
                    UIViewController.showViewController(storyBoardName: "Main", viewControllerId: "MainTabBarController")
                }
            }
        }
    }
    
    
    
    
   
    

    

}
