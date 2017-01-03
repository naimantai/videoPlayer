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
        if let imageURL = URL(string: url) {
            let imageData = try? Data(contentsOf: imageURL)
            thumbnail = UIImage(data: imageData!)
        } else {
            thumbnail = nil
        }
    }
    
}

