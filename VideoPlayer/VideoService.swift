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
<<<<<<< HEAD
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
=======
    let cloudBaseUrl: NSURL?
    
    init(key: String) {
        userKey = key
        cloudBaseUrl = NSURL(string: "https://static.tumblr.com/\(userKey)/")
    }
    
    func getVideos(filePath: String, completion: VideosArray? -> Void) {
        
        if let jsonFilePath = NSURL(string: filePath, relativeToURL: cloudBaseUrl) {
            
            print(jsonFilePath)
            let networkOperation = NetworkOperation(url: jsonFilePath)
            networkOperation.downloadJSONList{ (let jsonDictionary) in
>>>>>>> d24be9b5f6f367243313cba66c181f8a58e259c9
                let videosArray = VideosArray(videosDictionary: jsonDictionary)
                completion(videosArray)
            }

        } else {
            print("Could not construct a valid URL")
        }
        
    }
    
}








