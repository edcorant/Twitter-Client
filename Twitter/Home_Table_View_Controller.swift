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
        
        refresher.addTarget(self, action: #selector(load_tweets), for: .valueChanged)
        
        tableView.refreshControl = refresher        
    }
    
    @objc func load_tweets() {
        
        num_tweets = 20
        let feed_url = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let params = ["count" : num_tweets]
        
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
        // create 'user' dictionary (necessary for user details)
        let user = twitter_feed[indexPath.row]["user"] as! NSDictionary
        // extract url of profile photo from user dictionary
        let photo_url = URL(string: user["profile_image_url_https"] as! String)
        
        // populate cell object
        cell.profile_name_label.text = user["name"] as? String
        cell.tweet_content.text = twitter_feed[indexPath.row]["text"] as? String
        cell.user_handle.text = "@" + (user["screen_name"] as! String)
        
        if let image = try? Data(contentsOf: photo_url!) {
            cell.profile_photo.image = UIImage(data: image)
        }

        cell.id = twitter_feed[indexPath.row]["id"] as! Int
        cell.set_favorite(twitter_feed[indexPath.row]["favorited"] as! Bool)
        cell.set_retweet(twitter_feed[indexPath.row]["retweeted"] as! Bool)
        
        // return the cell object
        return cell
    }
    
    func get_sum_moar_tweets () {
        
        num_tweets += 40
        let feed_url = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let params = ["count" : num_tweets]
        
        TwitterAPICaller.client?.getDictionariesRequest(url: feed_url, parameters: params, success: { (tweets : [NSDictionary]) in
            
            // empty feed container
            self.twitter_feed.removeAll()
            // repopulate container
            for tweet in tweets {
                self.twitter_feed.append(tweet)
            }
            
            // update the feed
            self.tableView.reloadData()
            
        }, failure: { (Error) in
            print("Failed to retrieve tweets.")
        })
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        // this is triggered when the user scrolls all the way to the bottom of the feed
        if indexPath.row + 1 == twitter_feed.count {
            get_sum_moar_tweets()
        }
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
    
    // MARK: - Miscellaneous
    
    /*
     the two functions below are used to set the status bar elements, such as time and battery status,
     to a bright white color in order to better contrast with the dark navigation bar.
     
     referenced from: https://www.ioscreator.com/tutorials/change-color-status-bar-ios-tutorial
     */
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.barStyle = .black
        super.viewDidLoad()
        super.viewDidAppear(animated)
        self.load_tweets()
    }

}
