//
//  codeTest.swift
//  VideoPlayer
//
//  Created by Neven on 3/28/16.
//  Copyright © 2016 Neven. All rights reserved.
//

import Foundation
import UIKit


struct CodeTest {
    
    let thumbnail: UIImage?
    
    init(url: String) {
<<<<<<< HEAD
        if let imageURL = URL(string: url) {
            let imageData = try? Data(contentsOf: imageURL)
=======
        if let imageURL = NSURL(string: url) {
            let imageData = NSData(contentsOfURL: imageURL)
>>>>>>> d24be9b5f6f367243313cba66c181f8a58e259c9
            thumbnail = UIImage(data: imageData!)
        } else {
            thumbnail = nil
        }
    }
    
}

