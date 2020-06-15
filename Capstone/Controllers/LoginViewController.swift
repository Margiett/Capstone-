//
//  LoginViewController.swift
//  Capstone
//
//  Created by Margiett Gil on 5/28/20.
//  Copyright © 2020 Margiett Gil. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    private var authSession = FirebaseAuthManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logInButtonPressed(_ sender: UIButton) {
        guard let email = emailTextField.text, !email.isEmpty,
            let password = password.text, !password.isEmpty
            else {
                print("missing fields")
                return
        }
        authSession.signExisitingUser(email: email, password: password) { (result) in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showAlert(title: "Invalid password or email", message: "\(error.localizedDescription)")
                }
            case .success:
                DispatchQueue.main.async {
                    UIViewController.showViewController(storyBoardName: "Main", viewControllerId: "MainTabBarController")
                }
            }
        }
    }
    

}
