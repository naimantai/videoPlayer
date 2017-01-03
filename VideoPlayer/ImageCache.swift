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
    var cache: NSCache<AnyObject, AnyObject>
    var session: URLSession
    var task: URLSessionDownloadTask

    
    init () {
        cache = NSCache()
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
        task.resume()
    }

}


