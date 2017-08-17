//
//  ViewController.swift
//  Animal Kingdom
//
//  Created by Nursultan Askarbekuly on 10/08/2017.
//  Copyright © 2017 Nursultan Askarbekuly. All rights reserved.
//

import UIKit
import Reusable

class HomeController: UICollectionViewController {

    private var animals = [Animal]() {
        didSet{
            self.collectionView?.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        fetchAnimals()
        
    }
    
    func setupViews(){
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.backgroundColor = .clear
        collectionView?.register(cellType: AnimalCell.self)
    }
    
    
    func fetchAnimals() {
        AnimalManager.fetchAnimals { (success, error, list) in
            if success && list != nil {
                self.animals = list!
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return animals.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: AnimalCell.self)
        
//        let message = messages[(indexPath as NSIndexPath).item]
//        
//        cell.message = message
//        
//        cell.textView.text = message.text
//        
//        setupCell(cell, message: message)
//        
//        if let text = message.text {
//            //a text message
//            cell.bubbleWidthAnchor?.constant = estimateFrameForText(text).width + 32
//            cell.textView.isHidden = false
//        } else if message.imageUrl != nil {
//            //fall in here if its an image message
//            cell.bubbleWidthAnchor?.constant = 200
//            cell.textView.isHidden = true
//        }
//        
//        cell.playButton.isHidden = message.videoUrl == nil
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
//        var height: CGFloat = 80
//        
//        let message = messages[(indexPath as NSIndexPath).item]
//        if let text = message.text {
//            height = estimateFrameForText(text).height + 20
//        } else if let imageWidth = message.imageWidth?.floatValue, let imageHeight = message.imageHeight?.floatValue {
//            
//            // h1 / w1 = h2 / w2
//            // solve for h1
//            // h1 = h2 / w2 * w1
//            
//            height = CGFloat(imageHeight / imageWidth * 200)
//            
//        }
//        
//        let width = UIScreen.main.bounds.width
        return CGSize(width: 50, height: 50)
    }
    

}

