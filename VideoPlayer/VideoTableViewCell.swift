//
//  VideoTableViewCell.swift
//  VideoPlayer
//
//  Created by Neven on 5/2/16.
//  Copyright © 2016 Neven. All rights reserved.
//

import UIKit

class VideoTableViewCell: UITableViewCell {


    @IBOutlet weak var videoCell: UIView?
    @IBOutlet weak var thumbnail: UIImageView?
    @IBOutlet weak var catagoryLabel: UILabel?
    @IBOutlet weak var nameLabel: UILabel?
    var blackGradient: Bool = false
    var addWhiteGradient:Bool = false
    var addBlackGradient:Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func draw(_ rect: CGRect) {
        
        if blackGradient && !addBlackGradient {
            // Insert black gradient
            let color1 = UIColor(white: 0, alpha: 0).cgColor
            let color2 = UIColor(white: 0, alpha: 0.2).cgColor
            let gradient = CAGradientLayer()
            if let cell = thumbnail {
                gradient.frame = cell.frame
                gradient.colors = [color1,color2]
                gradient.locations = [0.25, 1.0]
                cell.layer.insertSublayer(gradient, at: 1)
            }
            addBlackGradient = true
        } else {
            if !addWhiteGradient {
                // Insert white gradient
                let color1 = UIColor(white: 1, alpha: 0).cgColor
                let color2 = UIColor(white: 1, alpha: 0.2).cgColor
                let gradient = CAGradientLayer()
                if let cell = thumbnail {
                    gradient.frame = cell.frame
                    gradient.colors = [color1,color2]
                    gradient.locations = [0.25, 1.0]
                    cell.layer.insertSublayer(gradient, at: 1)
                }
                addWhiteGradient = true
            }
        }
        

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
