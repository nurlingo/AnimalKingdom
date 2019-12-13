//
//  Service.swift
//  Animal Kingdom
//
//  Created by Nursultan Askarbekuly on 3/27/19.
//  Copyright © 2019 Nursultan Askarbekuly. All rights reserved.
//

import UIKit
import FirebaseDatabase
import SVProgressHUD

public typealias ImageDownloadHandler = (Result<NSData, Error>) -> ()

struct Service {
    
    static func fetchAnimals(_ completion:  @escaping (Result<[Animal], Error>) -> Void) {
        
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.show()
        
        let addressesRef = Database.database().reference().child("animals")
        addressesRef.observeSingleEvent(of: .value, with: { (snapshot) in

            if let result = snapshot.value as? NSArray{
                
                var animalsArray = [Animal]()
                
                for item in result {
                    if let item = item as? [String:Any]{
                        guard let animal = Animal(json: item) else {
                            print("serialization failed: ", item["firstName"] ?? "no such file")
                            continue
                        }
                        animalsArray.append(animal)
                    }
                }
                completion(.success(animalsArray))
            } else {
                completion(.failure(NSError(domain: "Service: Fetch animals", code: 1, userInfo: nil)))
            }
        
            SVProgressHUD.dismiss()
            
        }, withCancel: nil)
        
        
    }
    
    static func download(url: URL, handler: @escaping ImageDownloadHandler) {
        
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        let request = URLRequest(url:url)
        
        let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
            
            if error != nil {
                handler(.failure(error!))
                print("Error downloading an image: ", error!)
            }
            
            guard let localUrl = tempLocalUrl else {
                handler(.failure(NSError()))
                return
            }
            
            let rawImageData = NSData(contentsOf: localUrl)
            handler(.success(rawImageData!))
                
        }
        
        task.resume()
        
    }
    
}
