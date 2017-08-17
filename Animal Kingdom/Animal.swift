//
//  Animal.swift
//  Animal Kingdom
//
//  Created by Nursultan Askarbekuly on 10/08/2017.
//  Copyright © 2017 Nursultan Askarbekuly. All rights reserved.
//

import Foundation


import Foundation


struct Animal {
    
    let avatar: String
    let bio: String
    let firstName: String
    let lastName: String
    let title: String

    
}


extension Animal {

    init?(json: [String:Any]) {
        
        guard let avatar = json["avatar"] as? String,
            let bio = json["bio"] as? String,
            let firstName = json["firstName"] as? String,
            let lastName = json["lastName"] as? String,
            let title = json ["title"] as? String
        else {
            return nil
        }
        
        self.avatar = avatar
        self.bio = bio
        self.firstName = firstName
        self.lastName = lastName
        self.title = title
    }
}
