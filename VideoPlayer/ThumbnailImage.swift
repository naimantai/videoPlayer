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
    
    let imageURL: URL?
    var thumbnailImage: UIImage?
    
    init(url: String) {
        imageURL = URL(string: url)!
        thumbnailImage = self.toImage()
    }
    
    
    mutating func toImage() -> UIImage? {
        
        if let imageData = try? Data(contentsOf: imageURL!) {
            let image = UIImage(data: imageData)
            return image
        } else {
            print("Building image data failed.")
            return nil
        }
    
    }
    
    
    
    
}








