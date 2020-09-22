//
//  Tweet_Cell_View.swift
//  Twitter
//
//  Created by Eduardo Antonini on 9/21/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class Tweet_Cell_View: UITableViewCell {
    
    @IBOutlet weak var profile_photo: UIImageView!
    @IBOutlet weak var profile_name_label: UILabel!
    @IBOutlet weak var tweet_content: UILabel!
    @IBOutlet weak var user_handle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
