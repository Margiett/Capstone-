//
//  CommentVC.swift
//  Capstone
//
//  Created by Margiett Gil on 6/9/20.
//  Copyright © 2020 Margiett Gil. All rights reserved.
//

import UIKit
import FirebaseFirestore

class CommentVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var containerBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var commentTextField: UITextField!
    
    
    
    private var comments = [Comment] () {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    
    
    private var post: Post!
    private var originalValueForConstraint: CGFloat = 0
    
    private lazy var tapGesture: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer()
        gesture.addTarget(self, action: #selector(dismissKeyboard))
        return gesture
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
       originalValueForConstraint = containerBottomConstraint.constant
        tableView.dataSource = self
        
        commentTextField.delegate = self
        view.addGestureRecognizer(tapGesture)
       navigationItem.title = post.userName
        navigationItem.largeTitleDisplayMode = .never

    }
    
    
    
    
    private func registerKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func unregisterKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillshow(_ notification: Notification){
        print(notification.userInfo ?? "missing userInfo")
        guard let keyboardFrame = notification.userInfo?["UIKeyboardBoundsUserInfoKey"] as? CGRect else {
            return
        }
        containerBottomConstraint.constant = -(keyboardFrame.height - view.safeAreaInsets.bottom)
    }
    @objc private func keyboardWillHide(_ notification: Notification) {
        dismissKeyboard()
    }
    
    @objc private func dismissKeyboard() {
        containerBottomConstraint.constant = originalValueForConstraint
        commentTextField.resignFirstResponder()
    }
    
    @IBAction func sendButtonPressed(_ sender: UIButton) {
        dismissKeyboard()
        
        guard let commentText = commentTextField.text, !commentText.isEmpty else {
            showAlert(title: "Missing Fields", message: "A comment is required.")
            return
        }
        postComment(text: commentText)
        
    }
    
    private func postComment(text: String) {
        DatabaseService().postComment(post: post, comment: text) { [weak self] (result) in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.showAlert(title: "Try again", message: error.localizedDescription)
                }
            case .success:
                DispatchQueue.main.async {
                    self?.showAlert(title: "Comment posted 🥳", message: nil)
                }
            }
        }
    }


}

extension CommentVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath)
        let comment = comments[indexPath.row]
        //let dataString = comment.commentDate.dateValue().dateString()
        cell.textLabel?.text = comment.text
        //cell.detailTextLabel?.text = "@" + comment.commentedBy + " " + dataString
        return cell
    }
}

extension CommentVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        dismissKeyboard()
        return true
    }
}
