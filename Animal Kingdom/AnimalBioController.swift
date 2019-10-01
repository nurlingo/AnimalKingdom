//
//  AnimalBioController.swift
//  Animal Kingdom
//
//  Created by Nursultan Askarbekuly on 10/08/2017.
//  Copyright © 2017 Nursultan Askarbekuly. All rights reserved.
//

import UIKit

class AnimalBioController: UITableViewController {
    
    var animalViewModel: AnimalViewModel!
    
    let cellId = "cellId"
    
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
        let imageCompletionClosure = { ( imageData: NSData ) -> Void in
            
                    DispatchQueue.main.async {
                        UIView.animate(withDuration: 1.0, animations: {
                            self.avatarImageView.alpha = 1.0
                            self.avatarImageView.image = UIImage(data: imageData as Data)
                            self.view.setNeedsDisplay()
                        })
                    }
        }
        
        animalViewModel.download(completionHanlder: imageCompletionClosure)
        self.title = animalViewModel.title
        
        
        
    }
    
    func setupViews(){

        self.tableView.backgroundColor = .white
        self.tableView.register(AnimalBioCell.self, forCellReuseIdentifier: cellId)
        
        avatarImageView.frame = CGRect(x: 0, y: 0, width: Constant.screenWidth, height: Constant.screenWidth)
        tableView.tableHeaderView = avatarImageView
        
        tableView.estimatedRowHeight = 54
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = animalViewModel?.name
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        case 1:
            cell.textLabel?.text = animalViewModel?.bio
            cell.textLabel?.numberOfLines = 0
        default:
            print("extra cell appeared?")
        }
        
        return cell
    }
    
}
