//
//  NavigationBar.swift
//  VideoPlayer
//
//  Created by Neven on 8/25/16.
//  Copyright © 2016 Neven. All rights reserved.
//

import UIKit

class NavigationBar: UINavigationBar {


    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        // Set nav bar height
        let newHeight = CGFloat(64.0)
        self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.size.width, height: newHeight)
        
        if shouldShowSearchResults {
            self.backgroundColor = UIColor(red: 70/255, green: 55/255, blue: 95/255, alpha: 0.8)
        } else {
            self.backgroundColor = UIColor(red: 58/255, green: 170/255, blue: 210/255, alpha: 0.8)
        }
    }


}
