//
//  AnimalBioController.swift
//  Animal Kingdom
//
//  Created by Nursultan Askarbekuly on 10/08/2017.
//  Copyright © 2017 Nursultan Askarbekuly. All rights reserved.
//

import UIKit
import Firebase
import Kingfisher


class AnimalBioController: UITableViewController {
    
    var ingredients = [String]() {
        didSet{
            tableView.reloadData()
        }
    }
    
    let nutritionImageView = UIImageView()
    var passedImage: UIImage?
    var mealString : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationItem.setHidesBackButton(true, animated: true)
        
        setupViews()
        
        let userRef = Database.database().reference().child("users").child((Auth.auth().currentUser?.uid)!)
        userRef.observeSingleEvent(of: .value, with: {(userSnapshot) in
            
            
            let userDictionary = userSnapshot.value as! [String : Any]
            let bmiClass = userDictionary["userClass"] as! Int
            
            // get date when user started
            let startDateStr = userDictionary["startDate"] as! String
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
            guard let startDate = dateFormatter.date(from: startDateStr) else { return }
            
            // find difference between today and startDate
            let cal = Calendar.current
            let dateDifferenceComp = cal.dateComponents([.day], from: startDate, to: Date())
            guard let dayDifference = dateDifferenceComp.day else { return }
            
            //TODO:
            // add user property t
            
            let ref = Database.database().reference().child("nutritions").child(String(bmiClass)).child("day\(dayDifference % 7)") //.child("breakfast")
            
            //знак процента это modulo короч помогает сделать луп для дней чтобы подгружать другие рецепты дня. позже для 28 дней будет % 28 а в firebase когда day28 ты should вставить day0
            
            ref.observeSingleEvent(of: .value, with: {(mealSnapshot) in
                guard let day = mealSnapshot.value as? [String : Any] else {return}
                
                //nur
                guard let mealString = self.mealString else{return}
                if let meal = day[mealString.lowercased()] as? [String: Any],
                    let ingredientsStr = meal["ingredients"] as? String,
                    let imageString = meal["poster"] as? String{
                    
                    self.ingredients = ingredientsStr.components(separatedBy: ",")
                    let url = URL(string: imageString)
                    
                    self.nutritionImageView.kf.setImage(with: url)
                }
                
                
            })
            
        })
        
        
        
    }
    
    let ingedientCellId = "ingedientCellId"
    
    func setupViews(){
        
        view.backgroundColor = .white
        
        
        //nutritionImageView.image = //passedImage ?? UIImage(named: "placeholder")
        
        nutritionImageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/3)
        
        tableView.tableHeaderView = nutritionImageView
        tableView.backgroundColor = .white
        tableView.register(IngredientCell.self, forCellReuseIdentifier: ingedientCellId)
        tableView.estimatedRowHeight = 54
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorStyle = .none
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ingedientCellId) as! IngredientCell
        cell.textLabel?.text = ingredients[indexPath.row]
        return cell
    }
    
    
    
    
}
