//
//  TableTableViewController.swift
//  VideoPlayer
//
//  Created by Neven on 4/14/16.
//  Copyright © 2016 Neven. All rights reserved.
//

import UIKit
import CoreData

var videosArray: [Videos] = []
var filteredArray: [Videos] = []
var shouldShowSearchResults = false


class TableViewController: UITableViewController,UISearchResultsUpdating,CustomSearchControllerDelegate,ListViewControllerDelegate {
    @IBOutlet var searchItem: UIBarButtonItem?
    fileprivate let userKey: String = "vlkmvct"
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
        
        seedVideoData()
        fetch()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        configView()
    }
    
    func configView() {
        
        // Hook ListViewController to Storyboard
        mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        listViewController = mainStoryboard?.instantiateViewController(withIdentifier: "ListViewController") as? ListViewController
        
        // Set row height
        tableView.rowHeight = 133
    }
    

    // MARK: - Segue to Detail View
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "VideoDetail" {
            if let indexPath = tableView.indexPathForSelectedRow,
                   let destiationVC = (segue.destination as? VideoDetailViewController){
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

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if shouldShowSearchResults {
            return filteredArray.count
        }
        else {
            return videosArray.count
        }
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell") as! VideoTableViewCell
        var video:Videos
        
        cell.backgroundColor = UIColor.clear
        
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
            let image = imageCache.cache.object(forKey: thumbnailURL as AnyObject){
            cell.thumbnail?.image = image as? UIImage
            cell.blackGradient = true
            cell.setNeedsDisplay()
        }else{
            cell.thumbnail?.image = UIImage(named: "default")
            // Download Image
            if let thumbnailURL = video.thumbnail {
                imageCache.cacheImage(thumbnailURL) { (image) in
                    if let updateCell = tableView.cellForRow(at: indexPath) as? VideoTableViewCell {
                        updateCell.thumbnail?.image = image
                        self.imageCache.cache.setObject(image, forKey: thumbnailURL as AnyObject)
                        updateCell.blackGradient = true
                        updateCell.setNeedsDisplay()
                    }
                }
            }
        }
        return cell
    }
    
    
    // MARK: - Table view Delegate
    
    override func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.contentView.backgroundColor = UIColor.clear
        
        let highlightView = UIView()
        highlightView.backgroundColor = UIColor.clear
        cell?.selectedBackgroundView = highlightView
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.bounces = (scrollView.contentOffset.y > 100)
    }
    
    
    // MARK: - Video Fetching
    
    func retriveData() {
        
        let videoService = VideoService(key: userKey)
        videoService.getVideos(filePath) { (videosData) in
            if let videosDataArray = videosData {
                // Update UI
                DispatchQueue.main.async{
                
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
    
    @IBAction func closeDetailView(_ segue: UIStoryboardSegue) {
        print("Close Detail View")
        
        
    }
    
    @IBAction func searchButton(_ sender: UIBarButtonItem) {
        shouldShowSearchResults = true
        didChangeSearchText("")
        
        if let searchBar = customSearchController!.customSearchBar {
            // Scroll to top
            self.tableView.contentOffset = CGPoint(x: 0, y: 0 - self.tableView.contentInset.top)
            
            // disable Table View Scroll
            self.tableView.isScrollEnabled = false
            
            // Add search bar view
            self.navigationItem.rightBarButtonItem = nil
            self.navigationItem.titleView = searchBar
        }
        
        //Add List Subview
        if let list = listViewController {
            addChildViewController(list)
            self.tableView.addSubview(list.view)
            list.didMove(toParentViewController: self)
            list.delegate = self
        }
        
        tableView.reloadData()
        tableView.setNeedsDisplay()
        navigationController?.navigationBar.backgroundColor = UIColor(red: 70/255, green: 55/255, blue: 95/255, alpha: 0.8)
        navigationController?.navigationBar.setNeedsDisplay()
    }
    
    
    // MARK: - Search Results
    
    func filterContentForSearchText(_ searchText: String) {
        filteredArray = videosArray.filter({ (videos:Videos) -> Bool in
            let titleMatch = videos.title?.range(of: searchText, options: .caseInsensitive)
            let tagMatch = videos.category?.range(of: searchText, options: .caseInsensitive)
            if titleMatch != nil || tagMatch != nil {
                return true
            } else {
                return false
            }
        })
    }
    
    // CustomSearchController
    func configureCustomSearchController() {
        customSearchController = CustomSearchController(searchResultsController: self, searchBarFrame: CGRect(x: 5.0, y: 5.0, width: tableView.frame.size.width - 10.0, height: 30.0), searchBarFont: UIFont(name: "HelveticaNeue-Thin", size: 14.0)!, searchBarTextColor: UIColor.white, searchBarTintColor: UIColor.clear , backgroundColor:UIColor.clear)
        
        customSearchController!.customDelegate = self
    }

    
    
    // MARK: UISearchResultsUpdating delegate function
    
    func updateSearchResults(for searchController: UISearchController) {
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
                let cancelButton = searchBar.value(forKey: "cancelButton") as? UIButton{
                cancelButton.setTitle("Cancel", for: UIControlState())
                cancelButton.titleLabel!.font = font
            } else {
                print("set cancel fail")
            }
            
            shouldShowSearchResults = true
            print("didStartSearching")
            
            for subView in searchBar.subviews {
                if subView.isKind(of: UIView.self) {
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
        self.tableView.isScrollEnabled = true
        
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
    
    
    func didChangeSearchText(_ searchText: String) {
        filterContentForSearchText(searchText)
        print("didChangeSearchText")
        
        // Remove List View
        if let listView = listViewController?.view {
            if searchText.characters.count > 0 {
                // enable Table View Scroll
                self.tableView.isScrollEnabled = true
                
                print("remove list view")
                self.tableView.willRemoveSubview(listView)
                listView.removeFromSuperview()
            } else {
                // Scroll to top
                self.tableView.contentOffset = CGPoint(x: 0, y: 0 - self.tableView.contentInset.top)
                
                // disable Table View Scroll
                self.tableView.isScrollEnabled = false
                
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
    
    func didTapOnListRow(_ listString: String) {
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
    
    func removeViewController(_ viewController: UIViewController) {
        viewController.willMove(toParentViewController: nil)
        self.tableView.willRemoveSubview(viewController.view)
        viewController.view.removeFromSuperview()
        viewController.removeFromParentViewController()
    }
    
    
    
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
    

}
