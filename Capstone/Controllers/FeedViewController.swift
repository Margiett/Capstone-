//
//  FeedViewController.swift
//  Capstone
//
//  Created by Margiett Gil on 5/28/20.
//  Copyright © 2020 Margiett Gil. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class FeedViewController: UIViewController {
    
    @IBOutlet weak var feedCollectionView: UICollectionView!
    
    private var listener: ListenerRegistration?
    
    private var feed = [Post]() {
        didSet {
            DispatchQueue.main.async {
                self.feedCollectionView.reloadData()
            }
            
        }
    }
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        feedCollectionView.dataSource = self
        feedCollectionView.delegate = self
       
    }
    
    @IBAction func signOutButtonPressed(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            UIViewController.showViewController(storyBoardName: "Login", viewControllerId: "LoginViewController")
        } catch {
            DispatchQueue.main.async {
                self.showAlert(title: "Error signing out", message: "\(error.localizedDescription)")
            }
        }
    }

}

extension FeedViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return feed.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "feedCell", for: indexPath) as? FeedCell else {
            fatalError("could not downcast to feedCell")
        }
        let post = feed[indexPath.row]
        cell.confirgureCell(post: post)
        return cell
    }
}

extension FeedViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionView)
}
