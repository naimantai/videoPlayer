//
//  CustomSearchControllerViewController.swift
//  VideoPlayer
//
//  Created by Neven on 8/15/16.
//  Copyright © 2016 Neven. All rights reserved.
//

import UIKit

protocol CustomSearchControllerDelegate:class {
    func didStartSearching()
    
    func didTapOnSearchButton()
    
    func didTapOnCancelButton()
    
    func didChangeSearchText(_ searchText: String)
}

class CustomSearchController: UISearchController,UISearchBarDelegate {
    weak var customDelegate: CustomSearchControllerDelegate?
    var customSearchBar: CustomSearchBar?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: Initialization
    
    init(searchResultsController: UIViewController!, searchBarFrame: CGRect, searchBarFont: UIFont, searchBarTextColor: UIColor, searchBarTintColor: UIColor, backgroundColor: UIColor) {
        super.init(searchResultsController: searchResultsController)
        
        configureSearchBar(searchBarFrame, font: searchBarFont, textColor: searchBarTextColor, barColor: searchBarTintColor, bgColor: backgroundColor)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    
    // MARK: Custom functions
    
    func configureSearchBar(_ frame: CGRect, font: UIFont, textColor: UIColor, barColor: UIColor, bgColor: UIColor) {
        customSearchBar = CustomSearchBar(frame: frame, font: font , textColor: textColor, barColor: barColor)
        if let searchBar = customSearchBar {
            searchBar.barTintColor = barColor
            searchBar.tintColor = textColor
            searchBar.backgroundColor = bgColor
            searchBar.showsBookmarkButton = false
            searchBar.showsCancelButton = false
            searchBar.isTranslucent = true
            
            searchBar.delegate = self
        }


    }
    
    
    // MARK: UISearchBarDelegate functions
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        customDelegate?.didStartSearching()
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        customSearchBar?.resignFirstResponder()
        customDelegate?.didTapOnSearchButton()
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        customSearchBar?.resignFirstResponder()
        customDelegate?.didTapOnCancelButton()
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        customDelegate?.didChangeSearchText(searchText)
    }

}
