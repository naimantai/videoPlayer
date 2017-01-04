//
//  ImageCache.swift
//  VideoPlayer
//
//  Created by Neven on 8/8/16.
//  Copyright © 2016 Neven. All rights reserved.
//

import Foundation
import UIKit

class ImageCache {
<<<<<<< HEAD
    var cache: NSCache<AnyObject, AnyObject>
    var session: URLSession
    var task: URLSessionDownloadTask
=======
    var cache: NSCache
    var session: NSURLSession
    var task: NSURLSessionDownloadTask
>>>>>>> d24be9b5f6f367243313cba66c181f8a58e259c9

    
    init () {
        cache = NSCache()
<<<<<<< HEAD
        session = URLSession.shared
        task = URLSessionDownloadTask()
    }
    
    func cacheImage(_ url:URL, completion: @escaping (UIImage) -> ()) {
        task = session.downloadTask(with: url, completionHandler: { (location, response, error) -> Void in
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async(execute: {
                    completion(UIImage(data: data)!)
                })
            }
        }) 
=======
        session = NSURLSession.sharedSession()
        task = NSURLSessionDownloadTask()
    }
    
    func cacheImage(url:NSURL, completion: UIImage -> ()) {
        task = session.downloadTaskWithURL(url) { (location, response, error) -> Void in
            if let data = NSData(contentsOfURL: url) {
                dispatch_async(dispatch_get_main_queue(), {
                    completion(UIImage(data: data)!)
                })
            }
        }
>>>>>>> d24be9b5f6f367243313cba66c181f8a58e259c9
        task.resume()
    }

}


