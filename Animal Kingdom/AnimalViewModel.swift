//
//  AnimalViewModel.swift
//  Animal Kingdom
//
//  Created by Nursultan on 01/10/2019.
//  Copyright © 2019 Nursultan Askarbekuly. All rights reserved.
//

import UIKit


class AnimalViewModel {
    
    let title: String
    let name: String
    let bio: String
    private var imageURL: URL

    // Dependency Injection (DI)
    init(animal: Animal) {
        
        title = animal.title
        name = "\(animal.firstName) \(animal.lastName)"
        bio = animal.bio
        
        self.imageURL = URL(string: animal.avatar)!
    }
    
    func download(handler: @escaping ImageDownloadHandler) {
        Service.download(url: imageURL, handler: handler)
    }
    
}
