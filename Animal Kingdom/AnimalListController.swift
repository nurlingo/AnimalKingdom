//
//  ViewController.swift
//  Animal Kingdom
//
//  Created by Nursultan Askarbekuly on 10/08/2017.
//  Copyright © 2017 Nursultan Askarbekuly. All rights reserved.
//

import UIKit

class AnimalListController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var animalViewModels = [AnimalViewModel]()
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
        Service.fetchAnimals { [weak self] (res) in
            switch res {
            case .success(let animals):
                self?.animalViewModels = animals.map({return AnimalViewModel(animal: $0)})
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            case .failure(let err):
                print("Failed to fetch animals", err)
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return animalViewModels.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AnimalCell
        cell.animalViewModel = animalViewModels[indexPath.item]
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Constant.screenWidth/2 - 5, height: Constant.screenWidth/2 - 5)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let animalBioController = AnimalBioController()
        
        let animalVM = animalViewModels[indexPath.item]
        animalBioController.animalViewModel = animalVM
        self.navigationController?.pushViewController(animalBioController, animated: true)
    }

    

}

