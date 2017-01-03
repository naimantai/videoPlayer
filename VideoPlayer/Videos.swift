//
//  VideoStruct.swift
//  VideoPlayer
//
//  Created by Neven on 3/24/16.
//  Copyright © 2016 Neven. All rights reserved.
//

import Foundation
import UIKit

struct Videos {
    let title: String?
    let category: String?
    let description: String?
    let videoURL: URL?
    let thumbnail: URL?
    let cover: URL?
    
    init(videoDictionary: [String: AnyObject?]) {
        title = videoDictionary["title"] as? String
        category = videoDictionary["category"] as? String
        description = videoDictionary["description"] as? String
        if let url = videoDictionary["url"] as? String {
            videoURL = URL(string: url)
        } else {
            videoURL = nil
        }
        if let videoThumbnail = videoDictionary["thumbnail"] as? String {
            thumbnail = URL(string: videoThumbnail)
        } else {
            thumbnail = nil
        }
        if let videoCover = videoDictionary["cover"] as? String {
            cover = URL(string: videoCover)
        } else {
            cover = nil
        }
        
    }
    
    
    
    
}



