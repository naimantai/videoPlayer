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
<<<<<<< HEAD
    let videoURL: URL?
    let thumbnail: URL?
    let cover: URL?
=======
    let videoURL: NSURL?
    let thumbnail: NSURL?
    let cover: NSURL?
>>>>>>> d24be9b5f6f367243313cba66c181f8a58e259c9
    
    init(videoDictionary: [String: AnyObject?]) {
        title = videoDictionary["title"] as? String
        category = videoDictionary["category"] as? String
        description = videoDictionary["description"] as? String
        if let url = videoDictionary["url"] as? String {
<<<<<<< HEAD
            videoURL = URL(string: url)
=======
            videoURL = NSURL(string: url)
>>>>>>> d24be9b5f6f367243313cba66c181f8a58e259c9
        } else {
            videoURL = nil
        }
        if let videoThumbnail = videoDictionary["thumbnail"] as? String {
<<<<<<< HEAD
            thumbnail = URL(string: videoThumbnail)
=======
            thumbnail = NSURL(string: videoThumbnail)
>>>>>>> d24be9b5f6f367243313cba66c181f8a58e259c9
        } else {
            thumbnail = nil
        }
        if let videoCover = videoDictionary["cover"] as? String {
<<<<<<< HEAD
            cover = URL(string: videoCover)
=======
            cover = NSURL(string: videoCover)
>>>>>>> d24be9b5f6f367243313cba66c181f8a58e259c9
        } else {
            cover = nil
        }
        
    }
    
    
    
    
}



