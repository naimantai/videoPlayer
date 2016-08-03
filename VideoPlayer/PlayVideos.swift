//
//  PlayVideos.swift
//  VideoPlayer
//
//  Created by Neven on 4/11/16.
//  Copyright © 2016 Neven. All rights reserved.
//

import Foundation
import AVKit
import AVFoundation


class PlayVideos {
    
    let playerViewController: AVPlayerViewController
    
    init(url:NSURL) {
        let player = AVPlayer(URL: url)
        playerViewController = AVPlayerViewController()
        playerViewController.player = player
    }
    
}







