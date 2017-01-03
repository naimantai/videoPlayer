//
//  VideosArray.swift
//  VideoPlayer
//
//  Created by Neven on 3/29/16.
//  Copyright © 2016 Neven. All rights reserved.
//

import Foundation

struct VideosArray {
    
    var videosData: [Videos] = []
    
    init(videosDictionary: [String: AnyObject]?) {
        
        if let dataArray = videosDictionary?["items"] as? [[String: AnyObject]] {
        
            for data in dataArray {
                let videos = Videos(videoDictionary: data)
                videosData.append(videos)
            }

        } else {
            print("Building an array failed.")
        }
        
    }
    
}


