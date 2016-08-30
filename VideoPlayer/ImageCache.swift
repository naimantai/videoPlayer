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
    var cache: NSCache
    var session: NSURLSession
    var task: NSURLSessionDownloadTask

    
    init () {
        cache = NSCache()
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
        task.resume()
    }

}


