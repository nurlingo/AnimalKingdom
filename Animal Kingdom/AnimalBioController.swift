//
//  AnimalBioController.swift
//  Animal Kingdom
//
//  Created by Nursultan Askarbekuly on 10/08/2017.
//  Copyright © 2017 Nursultan Askarbekuly. All rights reserved.
//

import UIKit

class AnimalBioController: UITableViewController {
    
    var animal: Animal? {
        didSet{
            
            if let avatar = animal?.avatar {
                if let url = URL(string: avatar) {
                    avatarImageView.downloadImage(from: url)
                }
            }
            
            tableView.reloadData()
        }
    }
    
    let cellId = "cellId"
    
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
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
            if let firstName = animal?.firstName, let lastName = animal?.lastName {
                cell.textLabel?.text = "\(firstName) \(lastName)"
                cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 17)
            }
        case 1:
            if let bio = animal?.bio {
                cell.textLabel?.text = "\(bio)"
                cell.textLabel?.numberOfLines = 0
            }
        default:
            print("extra cell appeared?")
        }
        
        return cell
    }
    
    
    
    
}
