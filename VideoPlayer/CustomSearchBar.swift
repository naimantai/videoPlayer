//
//  CostomSearchBar.swift
//  VideoPlayer
//
//  Created by Neven on 8/15/16.
//  Copyright © 2016 Neven. All rights reserved.
//

import UIKit

class CustomSearchBar: UISearchBar {
    
    var preferredFont: UIFont?
    var preferredTextColor: UIColor?
    var preferredFieldColor: UIColor?
    var textField: UITextField?
    
    init(frame: CGRect, font: UIFont, textColor: UIColor, barColor: UIColor) {
        super.init(frame: frame)
        
        self.frame = frame
        preferredFont = font
        preferredTextColor = textColor
        preferredFieldColor = barColor
        translucent = true
        searchBarStyle = .Prominent
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func drawRect(rect: CGRect) {
        // Find the index of the search field in the search bar subviews.
        if let index = indexOfSearchFieldInSubview() {
            // Access the search field
            let searchField: UITextField = subviews[0].subviews[index] as! UITextField
            textField = searchField
            
            // Set Frame
            searchField.frame = CGRectOffset(searchField.frame, 0, 5)
            
            // Set the font and text color of the search field.
            searchField.font = preferredFont
            searchField.textColor = preferredTextColor
            searchField.tintColor = preferredTextColor
            
            // Set the background color of the search field.
            searchField.backgroundColor = preferredFieldColor
            
            // Set the font and text color of the placeholder.
            if let color = preferredTextColor,
                let font = preferredFont {
                let attributes = [
                    NSForegroundColorAttributeName: color,
                    NSFontAttributeName : font
                ]
                searchField.attributedPlaceholder = NSAttributedString(string: "Search for a name or a tag...", attributes:attributes)
            }
            
            // Set Image and Button in Text Field
            if let glassIconView = searchField.leftView as? UIImageView {
                //Magnifying glass
                glassIconView.image = glassIconView.image?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
                glassIconView.tintColor = preferredTextColor
            }
            
            // Set Clear Button
            if let clearButton = searchField.valueForKey("clearButton") as? UIButton {
                clearButton.setImage(clearButton.imageView?.image?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate), forState: .Normal)
                clearButton.tintColor = preferredTextColor
            }
            

            
        }
        super.drawRect(rect)
    }
    
    
    func indexOfSearchFieldInSubview() -> Int! {
        var index: Int!
        let searchBarView = subviews[0]
        
        for i in 0 ..< searchBarView.subviews.count {
            if searchBarView.subviews[i].isKindOfClass(UITextField) {
                index = i
                break
            }
        }
        return index
    }

}
