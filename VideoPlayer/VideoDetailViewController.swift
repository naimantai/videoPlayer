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
        
        
        // Media Player Setting
        if let videoURL = videoDic?.videoURL {
            // Set AVPlayer
            let player = AVPlayer(URL: videoURL)
            let playerViewController = AVPlayerViewController()
            playerViewController.player = player
//            self.presentViewController(playerViewController, animated: true) {
//                playerViewController.player!.play()
//            }


        }
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
