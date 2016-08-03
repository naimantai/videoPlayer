//
//  VideoTableViewCell.swift
//  VideoPlayer
//
//  Created by Neven on 5/2/16.
//  Copyright © 2016 Neven. All rights reserved.
//

import UIKit

class VideoTableViewCell: UITableViewCell {


    @IBOutlet weak var thumbnail: UIImageView?
    @IBOutlet weak var catagoryLabel: UILabel?
    @IBOutlet weak var nameLabel: UILabel?
    
    override func awakeFromNib() {

        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
