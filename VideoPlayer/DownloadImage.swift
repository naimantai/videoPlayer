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
    
    var session: NSURLSession = NSURLSession.sharedSession()
    var task: NSURLSessionDownloadTask = NSURLSessionDownloadTask()
    let thumbnailURL: NSURL
    
    init(url: NSURL) {
        thumbnailURL = url
    }
    
    func fetchImage(completion: UIImage -> ()) {

        // Download Image
        task = session.downloadTaskWithURL(thumbnailURL) { (location, response, error) -> Void in
            if let data = NSData(contentsOfURL: self.thumbnailURL){
                completion(UIImage(data: data)!)
                print("fetch image successfully")
            }
        }
        task.resume()
    }
    
}






