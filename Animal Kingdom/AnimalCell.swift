//
//  AnimalCell.swift
//  Animal Kingdom
//
//  Created by Nursultan Askarbekuly on 10/08/2017.
//  Copyright © 2017 Nursultan Askarbekuly. All rights reserved.
//

import UIKit

class AnimalCell: UICollectionViewCell {
    
    var animalViewModel: AnimalViewModel! {
        didSet {
            titleLabel.text = animalViewModel.title
            animalViewModel.download(completionHanlder: imageCompletionClosure!)
        }
    }
    
    let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.alpha = 0
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .black
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    func setupViews(){
        self.backgroundColor = .white
        self.contentView.addSubview(avatarImageView)
        self.contentView.addSubview(titleLabel)
    }
    
    func updateViewConstraints() {
        
        avatarImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        avatarImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        avatarImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        avatarImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: avatarImageView.widthAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: avatarImageView.centerXAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    var imageCompletionClosure: ImageDownloadCompletionClosure?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        updateViewConstraints()
        
        imageCompletionClosure = { ( imageData: NSData ) -> Void in
                    
                    DispatchQueue.main.async {
                        UIView.animate(withDuration: 1.0, animations: {
                            self.avatarImageView.alpha = 1.0
                            self.avatarImageView.image = UIImage(data: imageData as Data)
                        })
                    }
            
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

