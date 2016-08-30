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
    override func drawRect(rect: CGRect) {
        
        if shouldShowSearchResults {
            
            //// Color Declarations
            let color1 = UIColor(red: 41/255, green: 21/255, blue: 74/255, alpha: 1.0).CGColor
            let color2 = UIColor(red: 137/255, green: 57/255, blue: 120/255, alpha: 1.0).CGColor
            let color3 = UIColor(red: 254/255, green: 126/255, blue: 146/255, alpha: 1.0).CGColor
            let color4 = UIColor(red: 252/255, green: 151/255, blue: 140/255, alpha: 1.0).CGColor
            
            let context = UIGraphicsGetCurrentContext()
            
            //// Gradient Declarations
            let backgroundGradient = CGGradientCreateWithColors(CGColorSpaceCreateDeviceRGB(), [color1, color2, color3, color4], [0.0, 0.4, 0.85, 1.0])
            
            let mainScreen = UIScreen.mainScreen()
            let width = mainScreen.bounds.size.width
            let height = mainScreen.bounds.size.height
            
            //// Background Drawing
            let backgroundPath = UIBezierPath(rect: CGRectMake(0.0, -64.0, width, height + 20))
            CGContextSaveGState(context)
            backgroundPath.addClip()
            CGContextDrawLinearGradient(context, backgroundGradient,
                                        CGPointMake(160, 0),
                                        CGPointMake(160, height - 64),
                                        [.DrawsBeforeStartLocation, .DrawsAfterEndLocation])
            CGContextRestoreGState(context)
            
        } else {
            
            //// Color Declarations
            let color1 = UIColor(red: 58/255, green: 170/255, blue: 210/255, alpha: 1.0).CGColor
            let color2 = UIColor(red: 222/255, green: 233/255, blue: 239/255, alpha: 1.0).CGColor
            let color3 = UIColor(red: 251/255, green: 224/255, blue: 217/255, alpha: 1.0).CGColor
            
            let context = UIGraphicsGetCurrentContext()
            
            //// Gradient Declarations
            let backgroundGradient = CGGradientCreateWithColors(CGColorSpaceCreateDeviceRGB(), [color1, color2, color3], [0.0, 0.7, 1.0])
            
            let mainScreen = UIScreen.mainScreen()
            let width = mainScreen.bounds.size.width
            let height = mainScreen.bounds.size.height
            
            //// Background Drawing
            let backgroundPath = UIBezierPath(rect: CGRectMake(0.0, -64.0, width, height + 20))
            CGContextSaveGState(context)
            backgroundPath.addClip()
            CGContextDrawLinearGradient(context, backgroundGradient,
                                        CGPointMake(160, 0),
                                        CGPointMake(160, height - 64),
                                        [.DrawsBeforeStartLocation, .DrawsAfterEndLocation])
            CGContextRestoreGState(context)
        }
        
    }


}
