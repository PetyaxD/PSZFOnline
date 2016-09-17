//
//  LatestPostsTableViewCell.swift
//  PSZFONLINE
//
//  Created by Péter Bártfai on 2016. 09. 17..
//  Copyright © 2016. Péter Bártfai. All rights reserved.
//

import UIKit

class LatestPostsTableViewCell: UITableViewCell {

    @IBOutlet weak var post_title: UILabel!
    @IBOutlet weak var post_description: UILabel!
    @IBOutlet weak var featured_image: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
