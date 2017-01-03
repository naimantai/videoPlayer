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
    let cloudBaseUrl: URL?
    
    init(key: String) {
        userKey = key
        cloudBaseUrl = URL(string: "https://static.tumblr.com/\(userKey)/")
    }
    
    func getVideos(_ filePath: String, completion: @escaping (VideosArray?) -> Void) {
        
        if let jsonFilePath = URL(string: filePath, relativeTo: cloudBaseUrl) {
            
            print(jsonFilePath)
            let networkOperation = NetworkOperation(url: jsonFilePath)
            networkOperation.downloadJSONList{ (jsonDictionary) in
                let videosArray = VideosArray(videosDictionary: jsonDictionary)
                completion(videosArray)
            }

        } else {
            print("Could not construct a valid URL")
        }
        
    }
    
}








