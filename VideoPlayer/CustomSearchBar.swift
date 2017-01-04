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
<<<<<<< HEAD
        isTranslucent = true
        searchBarStyle = .prominent
=======
        translucent = true
        searchBarStyle = .Prominent
>>>>>>> d24be9b5f6f367243313cba66c181f8a58e259c9
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

<<<<<<< HEAD
    override func draw(_ rect: CGRect) {
=======
    override func drawRect(rect: CGRect) {
>>>>>>> d24be9b5f6f367243313cba66c181f8a58e259c9
        // Find the index of the search field in the search bar subviews.
        if let index = indexOfSearchFieldInSubview() {
            // Access the search field
            let searchField: UITextField = subviews[0].subviews[index] as! UITextField
            textField = searchField
            
            // Set Frame
<<<<<<< HEAD
            searchField.frame = searchField.frame.offsetBy(dx: 0, dy: 5)
=======
            searchField.frame = CGRectOffset(searchField.frame, 0, 5)
>>>>>>> d24be9b5f6f367243313cba66c181f8a58e259c9
            
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
<<<<<<< HEAD
                glassIconView.image = glassIconView.image?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
=======
                glassIconView.image = glassIconView.image?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
>>>>>>> d24be9b5f6f367243313cba66c181f8a58e259c9
                glassIconView.tintColor = preferredTextColor
            }
            
            // Set Clear Button
<<<<<<< HEAD
            if let clearButton = searchField.value(forKey: "clearButton") as? UIButton {
                clearButton.setImage(clearButton.imageView?.image?.withRenderingMode(UIImageRenderingMode.alwaysTemplate), for: UIControlState())
=======
            if let clearButton = searchField.valueForKey("clearButton") as? UIButton {
                clearButton.setImage(clearButton.imageView?.image?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate), forState: .Normal)
>>>>>>> d24be9b5f6f367243313cba66c181f8a58e259c9
                clearButton.tintColor = preferredTextColor
            }
            

            
        }
<<<<<<< HEAD
        super.draw(rect)
=======
        super.drawRect(rect)
>>>>>>> d24be9b5f6f367243313cba66c181f8a58e259c9
    }
    
    
    func indexOfSearchFieldInSubview() -> Int! {
        var index: Int!
        let searchBarView = subviews[0]
        
        for i in 0 ..< searchBarView.subviews.count {
<<<<<<< HEAD
            if searchBarView.subviews[i].isKind(of: UITextField.self) {
=======
            if searchBarView.subviews[i].isKindOfClass(UITextField) {
>>>>>>> d24be9b5f6f367243313cba66c181f8a58e259c9
                index = i
                break
            }
        }
        return index
    }

}
