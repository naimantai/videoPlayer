//
//  DownloadImage.swift
//  VideoPlayer
//
//  Created by Neven on 5/24/16.
//  Copyright © 2016 Neven. All rights reserved.
//

import Foundation
import UIKit

class DownloadImage {
    
    var session: URLSession = URLSession.shared
    var task: URLSessionDownloadTask = URLSessionDownloadTask()
    let thumbnailURL: URL
    
    init(url: URL) {
        thumbnailURL = url
    }
    
    func fetchImage(_ completion: @escaping (UIImage) -> ()) {

        // Download Image
        task = session.downloadTask(with: thumbnailURL, completionHandler: { (location, response, error) -> Void in
            if let data = try? Data(contentsOf: self.thumbnailURL){
                completion(UIImage(data: data)!)
                print("fetch image successfully")
            }
        }) 
        task.resume()
    }
    
}






