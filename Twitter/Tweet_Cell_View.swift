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
    @IBOutlet weak var like_button: UIButton!
    @IBOutlet weak var retweet_button: UIButton!
    
    var favorited: Bool = false
    var retweeted: Bool = false
    var id: Int = -1
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func set_favorite(_ is_favorited: Bool) {
        favorited = is_favorited
        
        // change 'like' icon
        if favorited {
            like_button.setImage(UIImage(named: "favor-icon-red"), for: UIControl.State.normal)
        }
        
        else {
            like_button.setImage(UIImage(named: "favor-icon"), for: UIControl.State.normal)
        }
    }
    
    func set_retweet(_ is_retweeted: Bool) {
        retweeted = is_retweeted
        
        // change 'retweet' icon
        if retweeted {
            retweet_button.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
            retweet_button.isEnabled = false
        }
        
        else {
            retweet_button.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
            retweet_button.isEnabled = true
        }
    }
    
    @IBAction func user_tapped_like(_ sender: Any) {
        
        if !favorited {
            TwitterAPICaller.client?.favorite_tweet(tweet_id: id, success: {
                self.set_favorite(true)
            }, failure: { (Error) in
                print("Like action failed: \(Error)")
            })
        }
        
        else {
            TwitterAPICaller.client?.unfavorite_tweet(tweet_id: id, success: {
                self.set_favorite(false)
            }, failure: { (Error) in
                print("Unlike action failed: \(Error)")
            })
        }
    }
    
    @IBAction func user_tapped_retweet(_ sender: Any) {
        
        if !retweeted {
            TwitterAPICaller.client?.favorite_tweet(tweet_id: id, success: {
                self.set_retweet(true)
            }, failure: { (Error) in
                print("Retweet action failed: \(Error)")
            })
        }
        
        else {
            TwitterAPICaller.client?.unfavorite_tweet(tweet_id: id, success: {
                self.set_retweet(false)
            }, failure: { (Error) in
                print("Undo retweet action failed: \(Error)")
            })
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
