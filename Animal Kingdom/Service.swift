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

public typealias ImageDownloadCompletionClosure = (_ imageData: NSData ) -> Void

struct Service {
    
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
    
    static func download(url: URL, completionHanlder: @escaping ImageDownloadCompletionClosure) {
        
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        let request = URLRequest(url:url)
        
        let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
            
            if let tempLocalUrl = tempLocalUrl, error == nil {
                if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                    let rawImageData = NSData(contentsOf: tempLocalUrl)
                    completionHanlder(rawImageData!)
                    print("Successfully downloaded. Status code: \(statusCode)")
                }
            } else {
                print("Error took place while downloading a file. Error description: \(String(describing: error?.localizedDescription))")
            }
        }
        
        task.resume()
        
    }
    
}
