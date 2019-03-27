//
//  UIImageView+.swift
//  Animal Kingdom
//
//  Created by Nursultan Askarbekuly on 3/27/19.
//  Copyright © 2019 Nursultan Askarbekuly. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    //FIXME: caching can be used
    public func downloadImage(from url: URL) {
        getData(from: url) { data, response, error in
            
            guard let data = data, error == nil else {
                print("error downloading image: \(response?.suggestedFilename ?? url.lastPathComponent)")
                return
            }
            
            DispatchQueue.main.async() {
                self.image = UIImage(data: data)
            }
        }
    }
}
