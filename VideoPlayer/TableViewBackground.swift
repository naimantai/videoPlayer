//
//  TableViewBackground.swift
//  VideoPlayer
//
//  Created by Neven on 8/25/16.
//  Copyright © 2016 Neven. All rights reserved.
//


import UIKit

class TableViewBackground: UITableView {
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        
        if shouldShowSearchResults {
            
            //// Color Declarations
            let color1 = UIColor(red: 41/255, green: 21/255, blue: 74/255, alpha: 1.0).cgColor
            let color2 = UIColor(red: 137/255, green: 57/255, blue: 120/255, alpha: 1.0).cgColor
            let color3 = UIColor(red: 254/255, green: 126/255, blue: 146/255, alpha: 1.0).cgColor
            let color4 = UIColor(red: 252/255, green: 151/255, blue: 140/255, alpha: 1.0).cgColor
            
            let context = UIGraphicsGetCurrentContext()
            
            //// Gradient Declarations
            let backgroundGradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: [color1, color2, color3, color4] as CFArray, locations: [0.0, 0.4, 0.85, 1.0])
            
            let mainScreen = UIScreen.main
            let width = mainScreen.bounds.size.width
            let height = mainScreen.bounds.size.height
            
            //// Background Drawing
            let backgroundPath = UIBezierPath(rect: CGRect(x: 0.0, y: -64.0, width: width, height: height + 20))
            context?.saveGState()
            backgroundPath.addClip()
            context?.drawLinearGradient(backgroundGradient!,
                                        start: CGPoint(x: 160, y: 0),
                                        end: CGPoint(x: 160, y: height - 64),
                                        options: [.drawsBeforeStartLocation, .drawsAfterEndLocation])
            context?.restoreGState()
            
        } else {
            
            //// Color Declarations
            let color1 = UIColor(red: 58/255, green: 170/255, blue: 210/255, alpha: 1.0).cgColor
            let color2 = UIColor(red: 222/255, green: 233/255, blue: 239/255, alpha: 1.0).cgColor
            let color3 = UIColor(red: 251/255, green: 224/255, blue: 217/255, alpha: 1.0).cgColor
            
            let context = UIGraphicsGetCurrentContext()
            
            //// Gradient Declarations
            let backgroundGradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: [color1, color2, color3] as CFArray, locations: [0.0, 0.7, 1.0])
            
            let mainScreen = UIScreen.main
            let width = mainScreen.bounds.size.width
            let height = mainScreen.bounds.size.height
            
            //// Background Drawing
            let backgroundPath = UIBezierPath(rect: CGRect(x: 0.0, y: -64.0, width: width, height: height + 20))
            context?.saveGState()
            backgroundPath.addClip()
            context?.drawLinearGradient(backgroundGradient!,
                                        start: CGPoint(x: 160, y: 0),
                                        end: CGPoint(x: 160, y: height - 64),
                                        options: [.drawsBeforeStartLocation, .drawsAfterEndLocation])
            context?.restoreGState()
        }
        
    }


}
