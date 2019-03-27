//
//  AnimalManager.swift
//  Animal Kingdom
//
//  Created by Nursultan Askarbekuly on 10/08/2017.
//  Copyright © 2017 Nursultan Askarbekuly. All rights reserved.
//

import Foundation
import FirebaseDatabase
import SVProgressHUD

class AnimalManager {
    
    static func fetchAnimals(_ completion:  @escaping (Bool, String?,[Animal]?) -> Void) {
        
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.show()
        
        let addressesRef = Database.database().reference().child("animals")
        addressesRef.observeSingleEvent(of: .value, with: { (snapshot) in

            if let result = snapshot.value as? NSArray{
                
                var array = [Animal]()
                
                for item in result {
                    if let item = item as? [String:Any]{
                        guard let animal = Animal(json: item) else {
                            print("serialization failed: ", item["firstName"] ?? "no such file")
                            continue
                        }
                        array.append(animal)
                    }
                }
                completion(true, nil, array)
            } else {
                completion(false, "couldn't form dictionary", nil)
            }
        
            SVProgressHUD.dismiss()
            
        }, withCancel: nil)
        
        
    }
    
}


