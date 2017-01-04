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
    
<<<<<<< HEAD
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
=======
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
>>>>>>> d24be9b5f6f367243313cba66c181f8a58e259c9
        task.resume()
    }
    
}






