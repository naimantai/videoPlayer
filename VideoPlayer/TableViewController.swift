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

class TableViewController: UITableViewController,UISearchResultsUpdating,UISearchBarDelegate,CustomSearchControllerDelegate {
    @IBOutlet weak var navigationItemBar: UINavigationItem!
    
    //https://dl.dropboxusercontent.com/u/25403899/VideoPlayer/VideoJSONTest.json
    private let userKey: String = "25403899/"
    let filePath: String = "VideoPlayer/VideoJSONTest.json"

    let imageCache = ImageCache()
    let searchController: UISearchController = UISearchController(searchResultsController: nil)
    var customSearchController: CustomSearchController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configView()
        retriveData()
        //configureSearchController()
        configureCustomSearchController()
    }
    
    override func viewDidAppear(animated: Bool) {
        configView()
    }
    
    func configView() {
        
        // Set row height
        tableView.rowHeight = 133
        
        // Set nav bar height
        let navBar = navigationController?.navigationBar
        let newHeight = CGFloat(64.0)
        navBar?.frame = CGRectMake((navBar?.frame.origin.x)!, (navBar?.frame.origin.y)!, (navBar?.frame.size.width)!, newHeight)
    }

    // MARK: - Segue to Detail View
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "VideoDetail" {
            if let indexPath = tableView.indexPathForSelectedRow,
                   destiationVC = (segue.destinationViewController as? VideoDetailViewController){
                let videoDic = videosArray[indexPath.row]
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
            print("videosArraycount")
            return videosArray.count
        }
        
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("VideoCell") as! VideoTableViewCell
        var video:Videos
        
        print("cellForRowAtIndexPath")
        
        if shouldShowSearchResults {
            video = filteredArray[indexPath.row]
            print("return filterArrayCell")
        }
        else {
            video = videosArray[indexPath.row]
            print("return videosArrayCell")
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
        if let image = imageCache.cache.objectForKey(indexPath.row){
            cell.thumbnail?.image = image as? UIImage
        }else{
            cell.thumbnail?.image = UIImage(named: "default")
            // Download Image
            if let thumbnailURL = video.thumbnail {
                imageCache.cacheImage(thumbnailURL) { (image) in
                    if let updateCell = tableView.cellForRowAtIndexPath(indexPath) as? VideoTableViewCell {
                        updateCell.thumbnail?.image = image
                        self.imageCache.cache.setObject(image, forKey: indexPath.row)
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
    
    @IBAction func close(segue: UIStoryboardSegue) {
    
    }
    
    // MARK: - Search Results
    func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchBar.sizeToFit()
        //navigationItemBar.titleView = searchController.searchBar
        tableView.tableHeaderView = searchController.searchBar
    }
    
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
        
        customSearchController.customSearchBar.placeholder = "Search for a name or a tag..."
        navigationItemBar.titleView = customSearchController.customSearchBar
        //tableView.tableHeaderView = customSearchController.customSearchBar
        customSearchController.customDelegate = self
    }
    
    
    // MARK: UISearchBarDelegate functions
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        shouldShowSearchResults = true
        self.tableView.reloadData()
        
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        shouldShowSearchResults = false
        self.tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        if !shouldShowSearchResults {
            shouldShowSearchResults = true
            tableView.reloadData()
        }
        
        searchController.searchBar.resignFirstResponder()
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
        shouldShowSearchResults = true
        tableView.reloadData()
    }
    
    
    func didTapOnSearchButton() {
        if !shouldShowSearchResults {
            shouldShowSearchResults = true
            tableView.reloadData()
        }
    }
    
    
    func didTapOnCancelButton() {
        shouldShowSearchResults = false
        tableView.reloadData()
    }
    
    
    func didChangeSearchText(searchText: String) {
        filterContentForSearchText(searchText)
        tableView.reloadData()
    }
    

}
