//
//  Home_Table_View_Controller.swift
//  Twitter
//
//  Created by Eduardo Antonini on 9/21/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class Home_Table_View_Controller: UITableViewController {

    // feed is array of dictionaries
    var twitter_feed = [NSDictionary]()
    var num_tweets: Int!
    
    let refresher = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        load_tweets()
        
        refresher.addTarget(self, action: #selector(load_tweets), for: .valueChanged)
        
        tableView.refreshControl = refresher
    }
    
    @objc func load_tweets() {
        
        let feed_url = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let params = ["count" : 20]
        
        TwitterAPICaller.client?.getDictionariesRequest(url: feed_url, parameters: params, success: { (tweets : [NSDictionary]) in
            
            // empty feed container
            self.twitter_feed.removeAll()
            // repopulate container
            for tweet in tweets {
                self.twitter_feed.append(tweet)
            }
            
            // update the feed
            self.tableView.reloadData()
            // cease updating
            self.refresher.endRefreshing()
            
        }, failure: { (Error) in
            print("Failed to retrieve tweets.")
        })
    }
    
    @IBAction func Sign_out_button(_ sender: Any) {
        // logout from api
        TwitterAPICaller.client?.logout()
        // revoke automatic sign in priviledges
        UserDefaults.standard.set(false, forKey: "Successful Sign In")
        // leave current view controller
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create cell object
        let cell = tableView.dequeueReusableCell(withIdentifier: "Tweet_Cell", for: indexPath) as! Tweet_Cell_View
        
        let user = twitter_feed[indexPath.row]["user"] as! NSDictionary
        
        let photo_url = URL(string: user["profile_image_url_https"] as! String)
        
        // populate cell object
        cell.profile_name_label.text = user["name"] as? String
        cell.tweet_content.text = twitter_feed[indexPath.row]["text"] as? String
        cell.user_handle.text = "@" + (user["screen_name"] as! String)
        
        if let image = try? Data(contentsOf: photo_url!) {
            cell.profile_photo.image = UIImage(data: image)
        }
        
        // return the cell object
        return cell
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return twitter_feed.count
    }


}
