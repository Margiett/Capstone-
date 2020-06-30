//
//  ProfileSegCell.swift
//  Capstone
//
//  Created by Margiett Gil on 6/24/20.
//  Copyright © 2020 Margiett Gil. All rights reserved.
//

import UIKit

class ProfileSegCell: UICollectionViewCell {
    
    private var collectionPost: Post!
    
    public lazy var view: UIView = {
          let layout = UIView()
          layout.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
          layout.layer.masksToBounds = false
          layout.clipsToBounds = false
          layout.layer.shadowColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1) //UIColor.black.cgColor
          layout.layer.shadowOpacity = 0.5
          layout.layer.shadowOffset = CGSize.zero
          layout.layer.shadowRadius = 5
          layout.layer.cornerRadius = 8
          return layout
      }()
      
      public lazy var dateDay: UILabel = {
          let label = UILabel()
          label.numberOfLines = 2
          label.font = UIFont(name: "Chalkduster", size: 20)
          label.textColor = #colorLiteral(red: 0, green: 0.7827044129, blue: 0.7580528855, alpha: 1)
          label.text = " 1 "
          return label
          
      }()
      
      public lazy var caption: UILabel = {
          let label = UILabel()
          label.numberOfLines = 2
          label.font = UIFont(name: "Chalkduster", size: 15)
          label.textColor = #colorLiteral(red: 0, green: 0.7827044129, blue: 0.7580528855, alpha: 1)
          label.textAlignment = .center
          return label
      }()
      
      public lazy var picture: UIImageView = {
          let imageView = UIImageView()
          imageView.image = UIImage(systemName: "square.grid.3x2")
          imageView.tintColor = .systemOrange
          imageView.contentMode = .scaleAspectFill
          return imageView
      }()

      
      override init(frame: CGRect) {
          super.init(frame: frame)
          commonInit()
      }
      
      required init?(coder: NSCoder) {
          super.init(coder: coder)
          commonInit()
      }
      private func commonInit() {
           setupView()
          setupDatedayLabel()
          setPictureOfPost()
         setupCaption()
         
      }
      
    
      
      private func setupDatedayLabel() { // this is the number
          addSubview(dateDay)
          dateDay.translatesAutoresizingMaskIntoConstraints = false
          NSLayoutConstraint.activate([
              dateDay.topAnchor.constraint(equalTo: topAnchor, constant: 12),
              dateDay.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12)
          ])

      }
      
      private func setupCaption() { // this the discription of the activity
          addSubview(caption)
          caption.translatesAutoresizingMaskIntoConstraints = false
          NSLayoutConstraint.activate([
              caption.topAnchor.constraint(equalTo: picture.bottomAnchor, constant: 8),
              caption.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
             caption.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
              
          ])
      }
      
      private func setPictureOfPost(){ // the six little sq
          addSubview(picture)
          picture.translatesAutoresizingMaskIntoConstraints = false
          NSLayoutConstraint.activate([
              picture.centerXAnchor.constraint(equalTo: centerXAnchor),
              picture.centerYAnchor.constraint(equalTo: centerYAnchor),
              picture.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4),
              picture.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4)
              

          ])
      }
      
    
      
      private func setupView() {
          addSubview(view)
          view.translatesAutoresizingMaskIntoConstraints = false
          NSLayoutConstraint.activate([
          
              view.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8),
                         view.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant:  -8),
                         view.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
                         view.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 8)
              
          ])
      }
     
      
      public func configureCell(for savedPost: Post) {
        collectionPost = savedPost
        dateDay.text = savedPost.datePosted.description
        caption.text = savedPost.caption
        picture.image = UIImage(named: savedPost.imageURL)
        
      }
    
}
