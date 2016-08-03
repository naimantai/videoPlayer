//
//  VideoService.swift
//  VideoPlayer
//
//  Created by Neven on 3/29/16.
//  Copyright © 2016 Neven. All rights reserved.
//
//                                     

import Foundation

class VideoService {
    
    let userKey:String
    let cloudBaseUrl: NSURL?
    
    init(key: String) {
        userKey = key
        cloudBaseUrl = NSURL(string: "https://dl.dropboxusercontent.com/u/\(userKey)")
    }
    
    func getVideos(filePath: String, completion: VideosArray? -> Void) {
        
        if let jsonFilePath = NSURL(string: filePath, relativeToURL: cloudBaseUrl) {
            
            print(jsonFilePath)
            let networkOperation = NetworkOperation(url: jsonFilePath)
            networkOperation.downloadJSONList{ (let jsonDictionary) in
                let videosArray = VideosArray(videosDictionary: jsonDictionary)
                completion(videosArray)
            }

        } else {
            print("Could not construct a valid URL")
        }
        
    }
    
}








