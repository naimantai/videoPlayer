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
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var cover: UIImageView?
    @IBOutlet weak var doneButton: UIButton?
    
    var indexPathRow: Int?
    
    var videoDic: Videos? {
        didSet {
            configView()
        }
    }

    
    func configView() {
        // Update UI
        if let title = videoDic?.title {
            titleLabel?.text = title
        }
        
        if let coverURL = videoDic?.cover {
            let downloadImage = DownloadImage(url: coverURL)
            downloadImage.fetchImage{ (image) in
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.cover?.image = image
                })
            }
        } else {
            cover = nil
        }
        
//        if let coverURL = videoDic?.cover,
//               data = NSData(contentsOfURL: coverURL){
//            cover?.image = UIImage(data: data)
//        } else {
//            cover = nil
//        }
        
        // set Button
        doneButton?.layer.borderWidth = 1.0
        doneButton?.layer.borderColor = UIColor.whiteColor().CGColor
        doneButton?.layer.cornerRadius = 2.0
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
    

    // MARK: - Slide to Preview or Next Cell
    func nextCell(indexPathRow:Int) -> Void {
        if self.indexPathRow != nil {
            cover?.image = UIImage(named: "default")
            let nextCellRow = indexPathRow + 1
            if nextCellRow < videosArray.count {
                self.indexPathRow = nextCellRow
                self.videoDic = videosArray[nextCellRow]
                print("Set next videoDic")
            }
        }
    }
    
    func prevCell(indexPathRow:Int) -> Void {
        if self.indexPathRow != nil {
            cover?.image = UIImage(named: "default")
            let prevCellRow = indexPathRow - 1
            if prevCellRow >= 0 {
                self.indexPathRow = prevCellRow
                self.videoDic = videosArray[prevCellRow]
                print("Set prev videoDic")
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

    @IBAction func tapToPlay(sender: AnyObject) {
        playVideo()
    }

    
}
