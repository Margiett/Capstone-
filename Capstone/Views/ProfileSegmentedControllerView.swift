//
//  ProfileSegmentedControllerView.swift
//  Capstone
//
//  Created by Margiett Gil on 6/24/20.
//  Copyright © 2020 Margiett Gil. All rights reserved.
//

import UIKit

class ProfileSegmentedControllerView: UIView {
    
    
    public lazy var collectionView: UICollectionView = {
           let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
            cv.backgroundColor = .white
            return cv
        }()
        
     
        
        override init(frame: CGRect) {
            super.init(frame: UIScreen.main.bounds)
            commonInit()
        }
        required init?(coder: NSCoder) {
            super.init(coder: coder)
        }
        
        private func commonInit(){
            setupCollectionViewConstraints()
            
        }
        
        private func setupCollectionViewConstraints(){
            addSubview(collectionView)
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
                collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
                collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
                collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
            ])
        }
        

    }



