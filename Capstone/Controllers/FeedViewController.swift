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
    @IBOutlet weak var faveButton: UIButton!
    @IBOutlet weak var commentButton: UIButton!
    
    private var post: Post
    
    private var listener: ListenerRegistration?
    private let databaseService = DatabaseService()
    
    private var isFavorite = false {
        didSet {
            if isFavorite {
                faveButton.imageView?.image = UIImage(systemName: "heart.fill")
                
            } else {
                faveButton.imageView?.image = UIImage(systemName: "heart")
            }
            
        }
    }
    
    
    private var feed = [Post]() {
        didSet {
            DispatchQueue.main.async {
                self.feedCollectionView.reloadData()
            }
            
        }
    }
    
    init?(coder: NSCoder, post: Post) {
        self.post = post
        super.init(coder: coder)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        feedCollectionView.dataSource = self
        feedCollectionView.delegate = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        listener = Firestore.firestore().collection(DatabaseService.postCollection).addSnapshotListener({[weak self] (snapshot, error) in
            if let error = error {
                DispatchQueue.main.async {
                    self?.showAlert(title: "Try again later", message: "There is a FireStore error: \(error.localizedDescription)")
                }
            } else if let snapshot = snapshot {
                let posts = snapshot.documents.map { Post($0.data()) }
                self?.feed = posts
            }
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        listener?.remove()
    }
    
    //MARK: this is favorting the post, the heart will be filled when is favorited and it will be empty when is not favorite
    @IBAction func favoriteButtonPressed(_ sender: UIButton) {
        if isFavorite {
            DatabaseService.shared.removeFromFavorites(post: post) { [weak self] (result) in
                switch result {
                case .failure(let error):
                    DispatchQueue.main.async {
                        self?.showAlert(title: "Failed to remove favorite", message: error.localizedDescription)
                    }
                case .success:
                    DispatchQueue.main.async {
                        self?.showAlert(title: "Item removed", message: nil)
                        self?.isFavorite = false
                    }
                }
            }
        } else {
            DatabaseService.shared.addToFaves(post: post) { [weak self] (result) in
                switch result {
                case .failure(let error):
                    DispatchQueue.main.async {
                        self?.showAlert(title: "Favoriting error", message: error.localizedDescription)
                    }
                case .success:
                    DispatchQueue.main.async {
                        self?.showAlert(title: "item was favorited", message: "❤️")
                        self?.isFavorite = true
                    }
                }
            }
        }
        
    }
   
    
    @IBAction func commentButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        let commentVC = CommentVC()
        navigationController?.pushViewController(commentVC, animated: true)
       
    }
    
    
    
    
    //MARK: the sign out button needs to be removed from here once, i have create the side meanue 
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

extension FeedViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxSize = UIScreen.main.bounds
        return CGSize(width: maxSize.width, height: maxSize.height * 0.70)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}
