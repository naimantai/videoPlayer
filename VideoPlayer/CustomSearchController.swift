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
    
<<<<<<< HEAD
    func didChangeSearchText(_ searchText: String)
=======
    func didChangeSearchText(searchText: String)
>>>>>>> d24be9b5f6f367243313cba66c181f8a58e259c9
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
    
<<<<<<< HEAD
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
=======
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
>>>>>>> d24be9b5f6f367243313cba66c181f8a58e259c9
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    
    // MARK: Custom functions
    
<<<<<<< HEAD
    func configureSearchBar(_ frame: CGRect, font: UIFont, textColor: UIColor, barColor: UIColor, bgColor: UIColor) {
=======
    func configureSearchBar(frame: CGRect, font: UIFont, textColor: UIColor, barColor: UIColor, bgColor: UIColor) {
>>>>>>> d24be9b5f6f367243313cba66c181f8a58e259c9
        customSearchBar = CustomSearchBar(frame: frame, font: font , textColor: textColor, barColor: barColor)
        if let searchBar = customSearchBar {
            searchBar.barTintColor = barColor
            searchBar.tintColor = textColor
            searchBar.backgroundColor = bgColor
            searchBar.showsBookmarkButton = false
            searchBar.showsCancelButton = false
<<<<<<< HEAD
            searchBar.isTranslucent = true
=======
            searchBar.translucent = true
>>>>>>> d24be9b5f6f367243313cba66c181f8a58e259c9
            
            searchBar.delegate = self
        }


    }
    
    
    // MARK: UISearchBarDelegate functions
    
<<<<<<< HEAD
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
=======
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
>>>>>>> d24be9b5f6f367243313cba66c181f8a58e259c9
        customDelegate?.didStartSearching()
    }
    
    
<<<<<<< HEAD
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
=======
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
>>>>>>> d24be9b5f6f367243313cba66c181f8a58e259c9
        customSearchBar?.resignFirstResponder()
        customDelegate?.didTapOnSearchButton()
    }
    
    
<<<<<<< HEAD
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
=======
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
>>>>>>> d24be9b5f6f367243313cba66c181f8a58e259c9
        customSearchBar?.resignFirstResponder()
        customDelegate?.didTapOnCancelButton()
    }
    
    
<<<<<<< HEAD
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
=======
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
>>>>>>> d24be9b5f6f367243313cba66c181f8a58e259c9
        customDelegate?.didChangeSearchText(searchText)
    }

}
