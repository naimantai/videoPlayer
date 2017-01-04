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
<<<<<<< HEAD
    override func draw(_ rect: CGRect) {
=======
    override func drawRect(rect: CGRect) {
>>>>>>> d24be9b5f6f367243313cba66c181f8a58e259c9
        
        if shouldShowSearchResults {
            
            //// Color Declarations
<<<<<<< HEAD
            let color1 = UIColor(red: 41/255, green: 21/255, blue: 74/255, alpha: 1.0).cgColor
            let color2 = UIColor(red: 137/255, green: 57/255, blue: 120/255, alpha: 1.0).cgColor
            let color3 = UIColor(red: 254/255, green: 126/255, blue: 146/255, alpha: 1.0).cgColor
            let color4 = UIColor(red: 252/255, green: 151/255, blue: 140/255, alpha: 1.0).cgColor
=======
            let color1 = UIColor(red: 41/255, green: 21/255, blue: 74/255, alpha: 1.0).CGColor
            let color2 = UIColor(red: 137/255, green: 57/255, blue: 120/255, alpha: 1.0).CGColor
            let color3 = UIColor(red: 254/255, green: 126/255, blue: 146/255, alpha: 1.0).CGColor
            let color4 = UIColor(red: 252/255, green: 151/255, blue: 140/255, alpha: 1.0).CGColor
>>>>>>> d24be9b5f6f367243313cba66c181f8a58e259c9
            
            let context = UIGraphicsGetCurrentContext()
            
            //// Gradient Declarations
<<<<<<< HEAD
            let backgroundGradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: [color1, color2, color3, color4] as CFArray, locations: [0.0, 0.4, 0.85, 1.0])
            
            let mainScreen = UIScreen.main
=======
            let backgroundGradient = CGGradientCreateWithColors(CGColorSpaceCreateDeviceRGB(), [color1, color2, color3, color4], [0.0, 0.4, 0.85, 1.0])
            
            let mainScreen = UIScreen.mainScreen()
>>>>>>> d24be9b5f6f367243313cba66c181f8a58e259c9
            let width = mainScreen.bounds.size.width
            let height = mainScreen.bounds.size.height
            
            //// Background Drawing
<<<<<<< HEAD
            let backgroundPath = UIBezierPath(rect: CGRect(x: 0.0, y: -64.0, width: width, height: height + 20))
            context?.saveGState()
            backgroundPath.addClip()
            context?.drawLinearGradient(backgroundGradient!,
                                        start: CGPoint(x: 160, y: 0),
                                        end: CGPoint(x: 160, y: height - 64),
                                        options: [.drawsBeforeStartLocation, .drawsAfterEndLocation])
            context?.restoreGState()
=======
            let backgroundPath = UIBezierPath(rect: CGRectMake(0.0, -64.0, width, height + 20))
            CGContextSaveGState(context)
            backgroundPath.addClip()
            CGContextDrawLinearGradient(context, backgroundGradient,
                                        CGPointMake(160, 0),
                                        CGPointMake(160, height - 64),
                                        [.DrawsBeforeStartLocation, .DrawsAfterEndLocation])
            CGContextRestoreGState(context)
>>>>>>> d24be9b5f6f367243313cba66c181f8a58e259c9
            
        } else {
            
            //// Color Declarations
<<<<<<< HEAD
            let color1 = UIColor(red: 58/255, green: 170/255, blue: 210/255, alpha: 1.0).cgColor
            let color2 = UIColor(red: 222/255, green: 233/255, blue: 239/255, alpha: 1.0).cgColor
            let color3 = UIColor(red: 251/255, green: 224/255, blue: 217/255, alpha: 1.0).cgColor
=======
            let color1 = UIColor(red: 58/255, green: 170/255, blue: 210/255, alpha: 1.0).CGColor
            let color2 = UIColor(red: 222/255, green: 233/255, blue: 239/255, alpha: 1.0).CGColor
            let color3 = UIColor(red: 251/255, green: 224/255, blue: 217/255, alpha: 1.0).CGColor
>>>>>>> d24be9b5f6f367243313cba66c181f8a58e259c9
            
            let context = UIGraphicsGetCurrentContext()
            
            //// Gradient Declarations
<<<<<<< HEAD
            let backgroundGradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: [color1, color2, color3] as CFArray, locations: [0.0, 0.7, 1.0])
            
            let mainScreen = UIScreen.main
=======
            let backgroundGradient = CGGradientCreateWithColors(CGColorSpaceCreateDeviceRGB(), [color1, color2, color3], [0.0, 0.7, 1.0])
            
            let mainScreen = UIScreen.mainScreen()
>>>>>>> d24be9b5f6f367243313cba66c181f8a58e259c9
            let width = mainScreen.bounds.size.width
            let height = mainScreen.bounds.size.height
            
            //// Background Drawing
<<<<<<< HEAD
            let backgroundPath = UIBezierPath(rect: CGRect(x: 0.0, y: -64.0, width: width, height: height + 20))
            context?.saveGState()
            backgroundPath.addClip()
            context?.drawLinearGradient(backgroundGradient!,
                                        start: CGPoint(x: 160, y: 0),
                                        end: CGPoint(x: 160, y: height - 64),
                                        options: [.drawsBeforeStartLocation, .drawsAfterEndLocation])
            context?.restoreGState()
=======
            let backgroundPath = UIBezierPath(rect: CGRectMake(0.0, -64.0, width, height + 20))
            CGContextSaveGState(context)
            backgroundPath.addClip()
            CGContextDrawLinearGradient(context, backgroundGradient,
                                        CGPointMake(160, 0),
                                        CGPointMake(160, height - 64),
                                        [.DrawsBeforeStartLocation, .DrawsAfterEndLocation])
            CGContextRestoreGState(context)
>>>>>>> d24be9b5f6f367243313cba66c181f8a58e259c9
        }
        
    }


}
