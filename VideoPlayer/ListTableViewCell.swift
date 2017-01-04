//
//  ListTableViewCell.swift
//  VideoPlayer
//
//  Created by Neven on 8/28/16.
//  Copyright © 2016 Neven. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var listLabel: UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

<<<<<<< HEAD
    override func setSelected(_ selected: Bool, animated: Bool) {
=======
    override func setSelected(selected: Bool, animated: Bool) {
>>>>>>> d24be9b5f6f367243313cba66c181f8a58e259c9
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
