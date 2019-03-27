//
//  ViewController.swift
//  Animal Kingdom
//
//  Created by Nursultan Askarbekuly on 10/08/2017.
//  Copyright © 2017 Nursultan Askarbekuly. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    private var animals = [Animal]() {
        didSet{
            self.collectionView?.reloadData()
        }
    }
    
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        fetchAnimals()
        
    }
    
    func setupViews(){
        
        self.title = "Animal Kingdom"
        
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.backgroundColor = .clear
        collectionView?.register(AnimalCell.self, forCellWithReuseIdentifier: cellId)
        
        let backItem = UIBarButtonItem()
        backItem.title = " "
        self.navigationItem.backBarButtonItem = backItem
        
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AnimalCell
        let animal = animals[indexPath.item]
        
        let url = URL(string: animal.avatar )
        
        //FIXME: replace kingfisher
//        cell.avatarImageView.kf.setImage(with: url)
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Constant.screenWidth/2 - 5, height: Constant.screenWidth/2 - 5)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let animalBioController = AnimalBioController()
        
        let animal = animals[indexPath.item]
        animalBioController.animal = animal
        animalBioController.title = animal.title
        
        
        self.navigationController?.pushViewController(animalBioController, animated: true)
    }

    

}

