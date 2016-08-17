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


class TableViewController: UITableViewController,UISearchResultsUpdating,CustomSearchControllerDelegate {
    @IBOutlet var searchItem: UIBarButtonItem?
    
    private let userKey: String = "25403899/"
    let filePath: String = "VideoPlayer/VideoJSONTest.json"

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
        
        // Set nav bar height
//        let navBar = navigationController?.navigationBar
//        let newHeight = CGFloat(64.0)
//        navBar?.frame = CGRectMake((navBar?.frame.origin.x)!, (navBar?.frame.origin.y)!, (navBar?.frame.size.width)!, newHeight)
    }
    
    
    // MARK: - Select List Row
    
    func selectListRow() {
        if let listString = selectedListString {
            customSearchController?.customSearchBar.text = listString
            shouldShowSearchResults = true
            didChangeSearchText(listString)
        }
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
        }else{
            cell.thumbnail?.image = UIImage(named: "default")
            // Download Image
            if let thumbnailURL = video.thumbnail {
                imageCache.cacheImage(thumbnailURL) { (image) in
                    if let updateCell = tableView.cellForRowAtIndexPath(indexPath) as? VideoTableViewCell {
                        updateCell.thumbnail?.image = image
                        self.imageCache.cache.setObject(image, forKey: thumbnailURL)
                    }
                }
            }
        }
        return cell
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
        if let searchBar = customSearchController!.customSearchBar {
            //Add search bar view
            self.navigationItem.rightBarButtonItem = nil
            self.navigationItem.titleView = searchBar
        }
        
        //Add List Subview
        if let list = listViewController {
            addChildViewController(list)
            self.tableView.addSubview(list.view)
            list.didMoveToParentViewController(self)
        }
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
        customSearchController = CustomSearchController(searchResultsController: self, searchBarFrame: CGRectMake(0.0, 0.0, tableView.frame.size.width, 64.0), searchBarFont: UIFont(name: "Futura", size: 12.0)!, searchBarTextColor: UIColor.darkGrayColor(), searchBarTintColor: UIColor(white: 1, alpha: 1), backgroundColor:UIColor.clearColor())
        
        if let searchBar = customSearchController!.customSearchBar {
        searchBar.placeholder = "Search for a name or a tag..."
        
        customSearchController!.customDelegate = self
        }
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
        customSearchController?.customSearchBar.showsCancelButton = true
        shouldShowSearchResults = true
        print("didStartSearching")        
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
        // Remove search bar
        customSearchController?.customSearchBar.showsCancelButton = false
        shouldShowSearchResults = false
        customSearchController?.customSearchBar.text = ""
        self.navigationItem.titleView = nil
        self.navigationItem.rightBarButtonItem = searchItem
        
        print("didTapOnCancelButton")
        // Remove ListViewController
        if let list = listViewController {
            removeViewController(list)
        }
        tableView.reloadData()
    }
    
    
    func didChangeSearchText(searchText: String) {
        filterContentForSearchText(searchText)
        print("didChangeSearchText")
        
        // Remove List View
        if let listView = listViewController?.view {
            if searchText.characters.count > 0 {
                print("remove list view")
                self.tableView.willRemoveSubview(listView)
                listView.removeFromSuperview()
            } else {
                // Add list View Back
                print("add list view back")
                self.tableView.addSubview(listView)
            }
        }
        tableView.reloadData()
    }
    
    
    // MARK: - Remove Child View Controller
    
    func removeViewController(viewController: UIViewController) {
        viewController.willMoveToParentViewController(nil)
        self.tableView.willRemoveSubview(viewController.view)
        viewController.view.removeFromSuperview()
        viewController.removeFromParentViewController()
    }

}
