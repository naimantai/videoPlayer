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
    
<<<<<<< HEAD
    let imageURL: URL?
    var thumbnailImage: UIImage?
    
    init(url: String) {
        imageURL = URL(string: url)!
=======
    let imageURL: NSURL?
    var thumbnailImage: UIImage?
    
    init(url: String) {
        imageURL = NSURL(string: url)!
>>>>>>> d24be9b5f6f367243313cba66c181f8a58e259c9
        thumbnailImage = self.toImage()
    }
    
    
    mutating func toImage() -> UIImage? {
        
<<<<<<< HEAD
        if let imageData = try? Data(contentsOf: imageURL!) {
=======
        if let imageData = NSData(contentsOfURL: imageURL!) {
>>>>>>> d24be9b5f6f367243313cba66c181f8a58e259c9
            let image = UIImage(data: imageData)
            return image
        } else {
            print("Building image data failed.")
            return nil
        }
    
    }
    
    
    
    
}








