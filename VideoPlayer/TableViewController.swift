//
//  TableTableViewController.swift
//  VideoPlayer
//
//  Created by Neven on 4/14/16.
//  Copyright © 2016 Neven. All rights reserved.
//

import UIKit
var videosArray: [Videos] = []
var filteredArray: [Videos] = []
var shouldShowSearchResults = false


class TableViewController: UITableViewController,UISearchResultsUpdating,CustomSearchControllerDelegate,ListViewControllerDelegate {
    @IBOutlet var searchItem: UIBarButtonItem?
    private let userKey: String = "vlkmvct"
    let filePath: String = "K2nocptij/videojsontest.json"
    
    let imageCache = ImageCache()
    let searchController: UISearchController = UISearchController(searchResultsController: nil)
    var customSearchController: CustomSearchController?
    var mainStoryboard:UIStoryboard?
    var listViewController: ListViewController?
    
    var selectedListString: String? {
        didSet {
            selectListRow()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        retriveData()
        configureCustomSearchController()
    }
    
    override func viewDidAppear(animated: Bool) {
        configView()
    }
    
    func configView() {
        
        // Hook ListViewController to Storyboard
        mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        listViewController = mainStoryboard?.instantiateViewControllerWithIdentifier("ListViewController") as? ListViewController
        
        // Set row height
        tableView.rowHeight = 133
    }
    

    // MARK: - Segue to Detail View
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "VideoDetail" {
            if let indexPath = tableView.indexPathForSelectedRow,
                   destiationVC = (segue.destinationViewController as? VideoDetailViewController){
                var videoDic:Videos?
                if shouldShowSearchResults {
                    videoDic = filteredArray[indexPath.row]
                } else {
                    videoDic = videosArray[indexPath.row]
                }
                destiationVC.videoDic = videoDic
                destiationVC.indexPathRow = indexPath.row
            }
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if shouldShowSearchResults {
            return filteredArray.count
        }
        else {
            return videosArray.count
        }
        
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("VideoCell") as! VideoTableViewCell
        var video:Videos
        
        cell.backgroundColor = UIColor.clearColor()
        
        if shouldShowSearchResults {
            video = filteredArray[indexPath.row]
        }
        else {
            video = videosArray[indexPath.row]
        }
        
        // set UI
        if let name = video.title {
            cell.nameLabel?.text = name
        } else {
            print("load name faild")
        }
        
        if let catagory = video.category {
            cell.catagoryLabel?.text = catagory
        } else {
            print("load catagory faild")
        }
        

        // Set image from cache
        if let thumbnailURL = video.thumbnail,
            image = imageCache.cache.objectForKey(thumbnailURL){
            cell.thumbnail?.image = image as? UIImage
            cell.blackGradient = true
            cell.setNeedsDisplay()
        }else{
            cell.thumbnail?.image = UIImage(named: "default")
            // Download Image
            if let thumbnailURL = video.thumbnail {
                imageCache.cacheImage(thumbnailURL) { (image) in
                    if let updateCell = tableView.cellForRowAtIndexPath(indexPath) as? VideoTableViewCell {
                        updateCell.thumbnail?.image = image
                        self.imageCache.cache.setObject(image, forKey: thumbnailURL)
                        updateCell.blackGradient = true
                        updateCell.setNeedsDisplay()
                    }
                }
            }
        }
        return cell
    }
    
    
    // MARK: - Table view Delegate
    
    override func tableView(tableView: UITableView, didHighlightRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.contentView.backgroundColor = UIColor.clearColor()
        
        let highlightView = UIView()
        highlightView.backgroundColor = UIColor.clearColor()
        cell?.selectedBackgroundView = highlightView
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        scrollView.bounces = (scrollView.contentOffset.y > 100)
    }
    
    
    // MARK: - Video Fetching
    
    func retriveData() {
        
        let videoService = VideoService(key: userKey)
        videoService.getVideos(filePath) { (let videosData) in
            if let videosDataArray = videosData {
                // Update UI
                dispatch_async(dispatch_get_main_queue()){
                
                    videosArray = videosDataArray.videosData
                    
                    self.tableView.reloadData()
                    print("videosArray Init successfully")
                }
            } else {
                print("videosData is nil")
            }
        }
    }
    
    
    // MARK: - IBAction
    
    @IBAction func closeDetailView(segue: UIStoryboardSegue) {
        print("Close Detail View")
        
        
    }
    
    @IBAction func searchButton(sender: UIBarButtonItem) {
        shouldShowSearchResults = true
        didChangeSearchText("")
        
        if let searchBar = customSearchController!.customSearchBar {
            // Scroll to top
            self.tableView.contentOffset = CGPointMake(0, 0 - self.tableView.contentInset.top)
            
            // disable Table View Scroll
            self.tableView.scrollEnabled = false
            
            // Add search bar view
            self.navigationItem.rightBarButtonItem = nil
            self.navigationItem.titleView = searchBar
        }
        
        //Add List Subview
        if let list = listViewController {
            addChildViewController(list)
            self.tableView.addSubview(list.view)
            list.didMoveToParentViewController(self)
            list.delegate = self
        }
        
        tableView.reloadData()
        tableView.setNeedsDisplay()
        navigationController?.navigationBar.backgroundColor = UIColor(red: 70/255, green: 55/255, blue: 95/255, alpha: 0.8)
        navigationController?.navigationBar.setNeedsDisplay()
    }
    
    
    // MARK: - Search Results
    
    func filterContentForSearchText(searchText: String) {
        filteredArray = videosArray.filter({ (videos:Videos) -> Bool in
            let titleMatch = videos.title?.rangeOfString(searchText, options: .CaseInsensitiveSearch)
            let tagMatch = videos.category?.rangeOfString(searchText, options: .CaseInsensitiveSearch)
            if titleMatch != nil || tagMatch != nil {
                return true
            } else {
                return false
            }
        })
    }
    
    // CustomSearchController
    func configureCustomSearchController() {
        customSearchController = CustomSearchController(searchResultsController: self, searchBarFrame: CGRectMake(5.0, 5.0, tableView.frame.size.width - 10.0, 30.0), searchBarFont: UIFont(name: "HelveticaNeue-Thin", size: 14.0)!, searchBarTextColor: UIColor.whiteColor(), searchBarTintColor: UIColor.clearColor() , backgroundColor:UIColor.clearColor())
        
        customSearchController!.customDelegate = self
    }

    
    
    // MARK: UISearchResultsUpdating delegate function
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else {
            return
        }
        // Filter the data array
        filterContentForSearchText(searchText)
        
        // Reload the tableview.
        self.tableView.reloadData()
        
    }
    
    
    // MARK: CustomSearchControllerDelegate functions
    
    func didStartSearching() {
        if let searchBar = customSearchController?.customSearchBar {
            searchBar.showsCancelButton = true
            
            // Set Cancel Button
            if let font = UIFont(name: "HelveticaNeue", size: 14),
                let cancelButton = searchBar.valueForKey("cancelButton") as? UIButton{
                cancelButton.setTitle("Cancel", forState: .Normal)
                cancelButton.titleLabel!.font = font
            } else {
                print("set cancel fail")
            }
            
            shouldShowSearchResults = true
            print("didStartSearching")
            
            for subView in searchBar.subviews {
                if subView.isKindOfClass(UIView) {
                    subView.frame = CGRect(x: subView.frame.origin.x, y: 5, width: subView.frame.size.width, height: subView.frame.size.height)
                }
                
            }
        }
        tableView.reloadData()
    }
    
    
    func didTapOnSearchButton() {
        if !shouldShowSearchResults {
            shouldShowSearchResults = true
            print("didTapOnSearchButton")
            tableView.reloadData()
        }
    }
    
    
    func didTapOnCancelButton() {
        // enable Table View Scroll
        self.tableView.scrollEnabled = true
        
        // Remove search bar
        customSearchController?.customSearchBar?.showsCancelButton = false
        shouldShowSearchResults = false
        customSearchController?.customSearchBar?.text = ""
        self.navigationItem.titleView = nil
        self.navigationItem.rightBarButtonItem = searchItem
        
        print("didTapOnCancelButton")
        // Remove ListViewController
        if let list = listViewController {
            removeViewController(list)
        }
        tableView.reloadData()
        tableView.setNeedsDisplay()
        navigationController?.navigationBar.backgroundColor = UIColor(red: 58/255, green: 170/255, blue: 210/255, alpha: 0.8)
        navigationController?.navigationBar.setNeedsDisplay()
    }
    
    
    func didChangeSearchText(searchText: String) {
        filterContentForSearchText(searchText)
        print("didChangeSearchText")
        
        // Remove List View
        if let listView = listViewController?.view {
            if searchText.characters.count > 0 {
                // enable Table View Scroll
                self.tableView.scrollEnabled = true
                
                print("remove list view")
                self.tableView.willRemoveSubview(listView)
                listView.removeFromSuperview()
            } else {
                // Scroll to top
                self.tableView.contentOffset = CGPointMake(0, 0 - self.tableView.contentInset.top)
                
                // disable Table View Scroll
                self.tableView.scrollEnabled = false
                
                // Add list View Back
                print("add list view back")
                if let list = listViewController {
                    list.delegate = self
                    self.tableView.addSubview(list.view)
                }
            }
        }
        tableView.reloadData()
    }
    
    
    // MARK: ListViewControllerDelegate functions
    
    func didTapOnListRow(listString: String) {
        self.selectedListString = listString
        print("detect tap Delegate")
    }
    
    
    // MARK: - Select List Row
    
    func selectListRow() {
        if let listString = selectedListString {
            customSearchController?.customSearchBar?.text = listString
            shouldShowSearchResults = true
            didChangeSearchText(listString)
        }
    }
    
    
    // MARK: - Remove Child View Controller
    
    func removeViewController(viewController: UIViewController) {
        viewController.willMoveToParentViewController(nil)
        self.tableView.willRemoveSubview(viewController.view)
        viewController.view.removeFromSuperview()
        viewController.removeFromParentViewController()
    }

}
