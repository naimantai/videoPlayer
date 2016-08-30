//
//  VideoDetailViewController.swift
//  VideoPlayer
//
//  Created by Neven on 5/23/16.
//  Copyright © 2016 Neven. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation



class VideoDetailViewController: UIViewController {
    @IBOutlet weak var tableDetailView: TableDetailView?
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var cover: UIImageView?
    @IBOutlet weak var doneButton: UIButton?
    var addGradient:Bool = false
    
    
    var indexPathRow: Int?
    let imageCache = ImageCache()
    
    var videoDic: Videos? {
        didSet {
            configView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configView()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configView() {
        // Update UI
        if let title = videoDic?.title {
            titleLabel?.text = title
        }
        
        if let key = videoDic?.cover?.absoluteString {
            if let coverImage = imageCache.cache.objectForKey(key){
                cover?.image = coverImage as? UIImage
            } else {
                cover?.image = UIImage(named: "detailBackground")
                if let coverURL = videoDic?.cover {
                    imageCache.cacheImage(coverURL) { (image) in
                        
                        if let cover = self.cover {
                            cover.image = image
                            self.imageCache.cache.setObject(image, forKey: key)
                            
                            // Add Black Gradient
                            if !self.addGradient {
                                let color1 = UIColor(white: 0, alpha: 0.3).CGColor
                                let color2 = UIColor(white: 0, alpha: 0).CGColor
                                let color3 = UIColor(white: 0, alpha: 0).CGColor
                                let color4 = UIColor(white: 0, alpha: 0.5).CGColor
                                let gradient = CAGradientLayer()
                                
                                gradient.frame = cover.bounds
                                gradient.colors = [color1, color2, color3, color4]
                                gradient.locations = [0.0, 0.15, 0.6, 1.0]
                                cover.layer.insertSublayer(gradient, atIndex: 1)
                                self.addGradient = true
                            }
                        }
                    }
                }
            }
        }
        // set Button
        doneButton?.layer.borderWidth = 1.0
        doneButton?.layer.borderColor = UIColor.whiteColor().CGColor
        doneButton?.layer.cornerRadius = 2.0
    }
    
    
    

    

    // MARK: - Slide to Preview or Next Cell
    func nextCell(indexPathRow:Int) -> Void {
        if self.indexPathRow != nil && shouldShowSearchResults {
            let nextCellRow = indexPathRow + 1
            if nextCellRow < filteredArray.count {
                self.indexPathRow = nextCellRow
                self.videoDic = filteredArray[nextCellRow]
                print("\(nextCellRow)")
            }
        } else {
            let nextCellRow = indexPathRow + 1
            if nextCellRow < videosArray.count {
                self.indexPathRow = nextCellRow
                self.videoDic = videosArray[nextCellRow]
                print("\(nextCellRow)")
            }
        }
    }
    
    func prevCell(indexPathRow:Int) -> Void {
        if self.indexPathRow != nil && shouldShowSearchResults {
            let prevCellRow = indexPathRow - 1
            if prevCellRow >= 0 {
                self.indexPathRow = prevCellRow
                self.videoDic = filteredArray[prevCellRow]
                print("\(prevCellRow)")
            }
        } else {
            let prevCellRow = indexPathRow - 1
            if prevCellRow >= 0 {
                self.indexPathRow = prevCellRow
                self.videoDic = videosArray[prevCellRow]
                print("\(prevCellRow)")
            }
        }
    }
    
    
    // MARK: - Play Video
    func playVideo() -> Void {
        // Media Player Setting
        if let videoURL = videoDic?.videoURL {
            // Set AVPlayer
            let playerViewController = AVPlayerViewController()
            let player = AVPlayer(URL: videoURL)
            playerViewController.player = player
            
            
            self.presentViewController(playerViewController, animated: true) {
                playerViewController.player!.play()
            }
            // Add notification block to Loop Video
            NSNotificationCenter.defaultCenter().addObserverForName(AVPlayerItemDidPlayToEndTimeNotification, object: player.currentItem, queue: nil)
            { notification in
                let t1 = CMTimeMake(5, 100);
                player.seekToTime(t1)
                player.play()
            }
        }
    }
    
    
    // MARK: - Share Video
    @IBAction func shareVideo(sender: UIButton) {
        
        // Set Info
        var shareInfo: String
        if let videoURL = videoDic?.videoURL {
            shareInfo = "Great UI design !\n" + videoURL.absoluteString
        } else {
            shareInfo = "Great UI design !\n"
        }
        
        // Set Activity Controller
        var activityController: UIActivityViewController
        
        if let img = cover?.image {
            activityController = UIActivityViewController(activityItems: [shareInfo,img], applicationActivities: nil)
        } else {
            activityController = UIActivityViewController(activityItems: [shareInfo], applicationActivities: nil)
        }
        
        self.presentViewController(activityController, animated: true, completion: nil)
        
    }
    
    
    // MARK: - Gesture Recognizer
    @IBAction func swipeLeft(sender: UISwipeGestureRecognizer) {
        print("swipe left")
        if let cellRow = indexPathRow {
            nextCell(cellRow)
        }
    }

    @IBAction func swipeRight(sender: AnyObject) {
        print("swipe Right")
        if let cellRow = indexPathRow {
            prevCell(cellRow)
        }
    }

    @IBAction func playVideo(sender: UIButton) {
        playVideo()
    }
    
}
