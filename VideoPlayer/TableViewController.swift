//
//  TableTableViewController.swift
//  VideoPlayer
//
//  Created by Neven on 4/14/16.
//  Copyright © 2016 Neven. All rights reserved.
//

import UIKit
<<<<<<< HEAD
import CoreData

=======
>>>>>>> d24be9b5f6f367243313cba66c181f8a58e259c9
var videosArray: [Videos] = []
var filteredArray: [Videos] = []
var shouldShowSearchResults = false


class TableViewController: UITableViewController,UISearchResultsUpdating,CustomSearchControllerDelegate,ListViewControllerDelegate {
    @IBOutlet var searchItem: UIBarButtonItem?
<<<<<<< HEAD
    fileprivate let userKey: String = "vlkmvct"
=======
    private let userKey: String = "vlkmvct"
>>>>>>> d24be9b5f6f367243313cba66c181f8a58e259c9
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
<<<<<<< HEAD
        
        seedVideoData()
        fetch()
    }
    
    override func viewDidAppear(_ animated: Bool) {
=======
    }
    
    override func viewDidAppear(animated: Bool) {
>>>>>>> d24be9b5f6f367243313cba66c181f8a58e259c9
        configView()
    }
    
    func configView() {
        
        // Hook ListViewController to Storyboard
        mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
<<<<<<< HEAD
        listViewController = mainStoryboard?.instantiateViewController(withIdentifier: "ListViewController") as? ListViewController
=======
        listViewController = mainStoryboard?.instantiateViewControllerWithIdentifier("ListViewController") as? ListViewController
>>>>>>> d24be9b5f6f367243313cba66c181f8a58e259c9
        
        // Set row height
        tableView.rowHeight = 133
    }
    

    // MARK: - Segue to Detail View
    
<<<<<<< HEAD
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "VideoDetail" {
            if let indexPath = tableView.indexPathForSelectedRow,
                   let destiationVC = (segue.destination as? VideoDetailViewController){
=======
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "VideoDetail" {
            if let indexPath = tableView.indexPathForSelectedRow,
                   destiationVC = (segue.destinationViewController as? VideoDetailViewController){
>>>>>>> d24be9b5f6f367243313cba66c181f8a58e259c9
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

<<<<<<< HEAD
    override func numberOfSections(in tableView: UITableView) -> Int {
=======
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
>>>>>>> d24be9b5f6f367243313cba66c181f8a58e259c9
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

<<<<<<< HEAD
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
=======
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
>>>>>>> d24be9b5f6f367243313cba66c181f8a58e259c9
        // #warning Incomplete implementation, return the number of rows
        if shouldShowSearchResults {
            return filteredArray.count
        }
        else {
            return videosArray.count
        }
        
    }

<<<<<<< HEAD
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell") as! VideoTableViewCell
        var video:Videos
        
        cell.backgroundColor = UIColor.clear
=======
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("VideoCell") as! VideoTableViewCell
        var video:Videos
        
        cell.backgroundColor = UIColor.clearColor()
>>>>>>> d24be9b5f6f367243313cba66c181f8a58e259c9
        
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
<<<<<<< HEAD
            let image = imageCache.cache.object(forKey: thumbnailURL as AnyObject){
=======
            image = imageCache.cache.objectForKey(thumbnailURL){
>>>>>>> d24be9b5f6f367243313cba66c181f8a58e259c9
            cell.thumbnail?.image = image as? UIImage
            cell.blackGradient = true
            cell.setNeedsDisplay()
        }else{
            cell.thumbnail?.image = UIImage(named: "default")
            // Download Image
            if let thumbnailURL = video.thumbnail {
                imageCache.cacheImage(thumbnailURL) { (image) in
<<<<<<< HEAD
                    if let updateCell = tableView.cellForRow(at: indexPath) as? VideoTableViewCell {
                        updateCell.thumbnail?.image = image
                        self.imageCache.cache.setObject(image, forKey: thumbnailURL as AnyObject)
=======
                    if let updateCell = tableView.cellForRowAtIndexPath(indexPath) as? VideoTableViewCell {
                        updateCell.thumbnail?.image = image
                        self.imageCache.cache.setObject(image, forKey: thumbnailURL)
>>>>>>> d24be9b5f6f367243313cba66c181f8a58e259c9
                        updateCell.blackGradient = true
                        updateCell.setNeedsDisplay()
                    }
                }
            }
        }
        return cell
    }
    
    
    // MARK: - Table view Delegate
    
<<<<<<< HEAD
    override func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.contentView.backgroundColor = UIColor.clear
        
        let highlightView = UIView()
        highlightView.backgroundColor = UIColor.clear
        cell?.selectedBackgroundView = highlightView
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
=======
    override func tableView(tableView: UITableView, didHighlightRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.contentView.backgroundColor = UIColor.clearColor()
        
        let highlightView = UIView()
        highlightView.backgroundColor = UIColor.clearColor()
        cell?.selectedBackgroundView = highlightView
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
>>>>>>> d24be9b5f6f367243313cba66c181f8a58e259c9
        scrollView.bounces = (scrollView.contentOffset.y > 100)
    }
    
    
    // MARK: - Video Fetching
    
    func retriveData() {
        
        let videoService = VideoService(key: userKey)
<<<<<<< HEAD
        videoService.getVideos(filePath) { (videosData) in
            if let videosDataArray = videosData {
                // Update UI
                DispatchQueue.main.async{
=======
        videoService.getVideos(filePath) { (let videosData) in
            if let videosDataArray = videosData {
                // Update UI
                dispatch_async(dispatch_get_main_queue()){
>>>>>>> d24be9b5f6f367243313cba66c181f8a58e259c9
                
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
    
<<<<<<< HEAD
    @IBAction func closeDetailView(_ segue: UIStoryboardSegue) {
=======
    @IBAction func closeDetailView(segue: UIStoryboardSegue) {
>>>>>>> d24be9b5f6f367243313cba66c181f8a58e259c9
        print("Close Detail View")
        
        
    }
    
<<<<<<< HEAD
    @IBAction func searchButton(_ sender: UIBarButtonItem) {
=======
    @IBAction func searchButton(sender: UIBarButtonItem) {
>>>>>>> d24be9b5f6f367243313cba66c181f8a58e259c9
        shouldShowSearchResults = true
        didChangeSearchText("")
        
        if let searchBar = customSearchController!.customSearchBar {
            // Scroll to top
<<<<<<< HEAD
            self.tableView.contentOffset = CGPoint(x: 0, y: 0 - self.tableView.contentInset.top)
            
            // disable Table View Scroll
            self.tableView.isScrollEnabled = false
=======
            self.tableView.contentOffset = CGPointMake(0, 0 - self.tableView.contentInset.top)
            
            // disable Table View Scroll
            self.tableView.scrollEnabled = false
>>>>>>> d24be9b5f6f367243313cba66c181f8a58e259c9
            
            // Add search bar view
            self.navigationItem.rightBarButtonItem = nil
            self.navigationItem.titleView = searchBar
        }
        
        //Add List Subview
        if let list = listViewController {
            addChildViewController(list)
            self.tableView.addSubview(list.view)
<<<<<<< HEAD
            list.didMove(toParentViewController: self)
=======
            list.didMoveToParentViewController(self)
>>>>>>> d24be9b5f6f367243313cba66c181f8a58e259c9
            list.delegate = self
        }
        
        tableView.reloadData()
        tableView.setNeedsDisplay()
        navigationController?.navigationBar.backgroundColor = UIColor(red: 70/255, green: 55/255, blue: 95/255, alpha: 0.8)
        navigationController?.navigationBar.setNeedsDisplay()
    }
    
    
    // MARK: - Search Results
    
<<<<<<< HEAD
    func filterContentForSearchText(_ searchText: String) {
        filteredArray = videosArray.filter({ (videos:Videos) -> Bool in
            let titleMatch = videos.title?.range(of: searchText, options: .caseInsensitive)
            let tagMatch = videos.category?.range(of: searchText, options: .caseInsensitive)
=======
    func filterContentForSearchText(searchText: String) {
        filteredArray = videosArray.filter({ (videos:Videos) -> Bool in
            let titleMatch = videos.title?.rangeOfString(searchText, options: .CaseInsensitiveSearch)
            let tagMatch = videos.category?.rangeOfString(searchText, options: .CaseInsensitiveSearch)
>>>>>>> d24be9b5f6f367243313cba66c181f8a58e259c9
            if titleMatch != nil || tagMatch != nil {
                return true
            } else {
                return false
            }
        })
    }
    
    // CustomSearchController
    func configureCustomSearchController() {
<<<<<<< HEAD
        customSearchController = CustomSearchController(searchResultsController: self, searchBarFrame: CGRect(x: 5.0, y: 5.0, width: tableView.frame.size.width - 10.0, height: 30.0), searchBarFont: UIFont(name: "HelveticaNeue-Thin", size: 14.0)!, searchBarTextColor: UIColor.white, searchBarTintColor: UIColor.clear , backgroundColor:UIColor.clear)
=======
        customSearchController = CustomSearchController(searchResultsController: self, searchBarFrame: CGRectMake(5.0, 5.0, tableView.frame.size.width - 10.0, 30.0), searchBarFont: UIFont(name: "HelveticaNeue-Thin", size: 14.0)!, searchBarTextColor: UIColor.whiteColor(), searchBarTintColor: UIColor.clearColor() , backgroundColor:UIColor.clearColor())
>>>>>>> d24be9b5f6f367243313cba66c181f8a58e259c9
        
        customSearchController!.customDelegate = self
    }

    
    
    // MARK: UISearchResultsUpdating delegate function
    
<<<<<<< HEAD
    func updateSearchResults(for searchController: UISearchController) {
=======
    func updateSearchResultsForSearchController(searchController: UISearchController) {
>>>>>>> d24be9b5f6f367243313cba66c181f8a58e259c9
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
<<<<<<< HEAD
                let cancelButton = searchBar.value(forKey: "cancelButton") as? UIButton{
                cancelButton.setTitle("Cancel", for: UIControlState())
=======
                let cancelButton = searchBar.valueForKey("cancelButton") as? UIButton{
                cancelButton.setTitle("Cancel", forState: .Normal)
>>>>>>> d24be9b5f6f367243313cba66c181f8a58e259c9
                cancelButton.titleLabel!.font = font
            } else {
                print("set cancel fail")
            }
            
            shouldShowSearchResults = true
            print("didStartSearching")
            
            for subView in searchBar.subviews {
<<<<<<< HEAD
                if subView.isKind(of: UIView.self) {
=======
                if subView.isKindOfClass(UIView) {
>>>>>>> d24be9b5f6f367243313cba66c181f8a58e259c9
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
<<<<<<< HEAD
        self.tableView.isScrollEnabled = true
=======
        self.tableView.scrollEnabled = true
>>>>>>> d24be9b5f6f367243313cba66c181f8a58e259c9
        
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
    
    
<<<<<<< HEAD
    func didChangeSearchText(_ searchText: String) {
=======
    func didChangeSearchText(searchText: String) {
>>>>>>> d24be9b5f6f367243313cba66c181f8a58e259c9
        filterContentForSearchText(searchText)
        print("didChangeSearchText")
        
        // Remove List View
        if let listView = listViewController?.view {
            if searchText.characters.count > 0 {
                // enable Table View Scroll
<<<<<<< HEAD
                self.tableView.isScrollEnabled = true
=======
                self.tableView.scrollEnabled = true
>>>>>>> d24be9b5f6f367243313cba66c181f8a58e259c9
                
                print("remove list view")
                self.tableView.willRemoveSubview(listView)
                listView.removeFromSuperview()
            } else {
                // Scroll to top
<<<<<<< HEAD
                self.tableView.contentOffset = CGPoint(x: 0, y: 0 - self.tableView.contentInset.top)
                
                // disable Table View Scroll
                self.tableView.isScrollEnabled = false
=======
                self.tableView.contentOffset = CGPointMake(0, 0 - self.tableView.contentInset.top)
                
                // disable Table View Scroll
                self.tableView.scrollEnabled = false
>>>>>>> d24be9b5f6f367243313cba66c181f8a58e259c9
                
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
    
<<<<<<< HEAD
    func didTapOnListRow(_ listString: String) {
=======
    func didTapOnListRow(listString: String) {
>>>>>>> d24be9b5f6f367243313cba66c181f8a58e259c9
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
    
<<<<<<< HEAD
    func removeViewController(_ viewController: UIViewController) {
        viewController.willMove(toParentViewController: nil)
=======
    func removeViewController(viewController: UIViewController) {
        viewController.willMoveToParentViewController(nil)
>>>>>>> d24be9b5f6f367243313cba66c181f8a58e259c9
        self.tableView.willRemoveSubview(viewController.view)
        viewController.view.removeFromSuperview()
        viewController.removeFromParentViewController()
    }
<<<<<<< HEAD
    
    
    
    // MARK: - CoreData manage
    
    func seedVideoData() {
        
        // create an instance of our managedObjectContext
        let moc = DataController().managedObjectContext
        
        // we set up our entity by selecting the entity and context that we're targeting
        let entity = NSEntityDescription.insertNewObject(forEntityName: "VideoDataEntity", into: moc) as! VideoDataEntity
        
        // add our data
        entity.setValue("try1", forKey: "title")
        entity.setValue("try2", forKey: "catagory")
        
        // we save our entity
        do {
            try moc.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
    }
    
    
    func fetch() {
        let moc = DataController().managedObjectContext
        let personFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "VideoDataEntity")
        
        do {
            let fetchedVideoData = try moc.fetch(personFetch) as! [VideoDataEntity]
            print(fetchedVideoData[2].catagory)
            
        } catch {
            fatalError("Failed to fetch person: \(error)")
        }
    }
    
=======
>>>>>>> d24be9b5f6f367243313cba66c181f8a58e259c9

}
