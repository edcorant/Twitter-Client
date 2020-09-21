//
//  Home_Table_View_Controller.swift
//  Twitter
//
//  Created by Eduardo Antonini on 9/21/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class Home_Table_View_Controller: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func Sign_out_button(_ sender: Any) {
        // logout from api
        TwitterAPICaller.client?.logout()
        // revoke automatic sign in priviledges
        UserDefaults.standard.set(false, forKey: "Successful Sign In")
        // leave current view controller
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }


}
