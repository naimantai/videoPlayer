//
//  URLToImage.swift
//  VideoPlayer
//
//  Created by Neven on 4/11/16.
//  Copyright © 2016 Neven. All rights reserved.
//

import Foundation
import UIKit

struct ThumbnailImage {
    
    let imageURL: NSURL?
    var thumbnailImage: UIImage?
    
    init(url: String) {
        imageURL = NSURL(string: url)!
        thumbnailImage = self.toImage()
    }
    
    
    mutating func toImage() -> UIImage? {
        
        if let imageData = NSData(contentsOfURL: imageURL!) {
            let image = UIImage(data: imageData)
            return image
        } else {
            print("Building image data failed.")
            return nil
        }
    
    }
    
    
    
    
}








