//
//  Tweet_View_Controller.swift
//  Twitter
//
//  Created by Eduardo Antonini on 9/28/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class Tweet_View_Controller: UIViewController {

    @IBOutlet weak var tweet_body: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tweet_body.becomeFirstResponder()
    }
    
    @IBAction func user_tapped_cancel(_ sender: Any) {
        // dismiss this view controller
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func user_tapped_tweet(_ sender: Any) {
        
        if !tweet_body.text.isEmpty {
            TwitterAPICaller.client?.post_tweet(tweetString: tweet_body.text,
                                                success: { self.dismiss(animated: true, completion: nil) },
                                                failure: {(Error) in print("Error posting tweet \(Error)") })
        }
        
        else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
