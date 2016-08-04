//
//  TableTableViewController.swift
//  VideoPlayer
//
//  Created by Neven on 4/14/16.
//  Copyright © 2016 Neven. All rights reserved.
//

import UIKit
var videosArray: [Videos] = []

class TableViewController: UITableViewController {
    
    //https://dl.dropboxusercontent.com/u/25403899/VideoPlayer/VideoJSONTest.json
    private let userKey: String = "25403899/"
    let filePath: String = "VideoPlayer/VideoJSONTest.json"

    var cache: NSCache = NSCache()
    var session: NSURLSession = NSURLSession.sharedSession()
    var task: NSURLSessionDownloadTask = NSURLSessionDownloadTask()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configView()
        retriveData()
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
        return videosArray.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("VideoCell") as! VideoTableViewCell
        let video = videosArray[indexPath.row]
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
        if (self.cache.objectForKey(indexPath.row) != nil){
            cell.thumbnail?.image = self.cache.objectForKey(indexPath.row) as? UIImage
        }else{
            cell.thumbnail?.image = UIImage(named: "default")
            // Download Image
                if let thumbnailURL = video.thumbnail {
                    task = session.downloadTaskWithURL(thumbnailURL) { (location, response, error) -> Void in
                        if let data = NSData(contentsOfURL: thumbnailURL){
                            // Get main queue for image
                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                // Update cell
                                if let updateCell = tableView.cellForRowAtIndexPath(indexPath) as? VideoTableViewCell {
                                    let thumbnailImg:UIImage! = UIImage(data: data)
                                    updateCell.thumbnail?.image = thumbnailImg
                                    self.cache.setObject(thumbnailImg, forKey: indexPath.row)
                                }
                            })
                        }
                    }
                    task.resume()
                }
        }
        
        
        // Insert tableView cell gradient
        let color1 = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        let color2 = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
        let gradient = CAGradientLayer()
        gradient.frame = cell.frame
        gradient.colors = [color1.CGColor,color2.CGColor]
        cell.layer.insertSublayer(gradient, atIndex: 1)
        
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
    
    

}
