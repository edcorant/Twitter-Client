//
//  Sign_In_View_Controller.swift
//  Twitter
//
//  Created by Eduardo Antonini on 9/21/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class Sign_In_View_Controller: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        // if user was already signed in
        if UserDefaults.standard.bool(forKey: "Successful Sign In") {
            // skip sign in and perform segueway
            self.performSegue(withIdentifier: "Sign_In_Successful", sender: self)
        }
    }
    
    @IBAction func sign_in_button(_ sender: Any) {
        
        let Twitter_Auth = "https://api.twitter.com/oauth/request_token"
        
        TwitterAPICaller.client?.login(url: Twitter_Auth, success: {
            // write sign in credentials to disc
            UserDefaults.standard.set(true, forKey: "Successful Sign In")
            // proceed to home screen
            self.performSegue(withIdentifier: "Sign_In_Successful", sender: self)
        }, failure: { (Error) in
            print("Could not log in.")
        })
    }

}
