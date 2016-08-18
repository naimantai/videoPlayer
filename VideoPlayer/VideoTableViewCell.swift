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
    
    override func awakeFromNib() {
        // Insert tableView cell gradient
        let color1 = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        let color2 = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
        let gradient = CAGradientLayer()
        if let cell = videoCell {
            gradient.frame = cell.frame
            gradient.colors = [color1.CGColor,color2.CGColor]
            cell.layer.insertSublayer(gradient, atIndex: 1)
        }

        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
