//
//  feedVC.swift
//  hackprinceton
//
//  Created by Grant Kim on 11/12/17.
//  Copyright © 2017 Grant Kim. All rights reserved.
//

import UIKit
import Parse

var postuuid = [String]()

class feedVC: UITableViewController {

    // hold info from server
    var usernameArray = [String]()
    var picArray = [PFFile]()
    var titleArray = [String]()
    var uuidArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // dynamic cell length
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 450
        /**
        let postQuery = PFQuery(className: "posts")
        postQuery.whereKey("uuid", equalTo: postuuid.last!)
        postQuery.findObjectsInBackground(block: { (objects, error) -> Void in
            if error == nil {
                
                // clean up
                self.usernameArray.removeAll(keepingCapacity: false)
                self.picArray.removeAll(keepingCapacity: false)
                self.titleArray.removeAll(keepingCapacity: false)
                self.uuidArray.removeAll(keepingCapacity: false)
                
                // find related objects
                for object in objects! {
                    self.usernameArray.append(object.object(forKey: "username") as! String)
                    self.picArray.append(object.object(forKey: "pic") as! PFFile)
                    self.titleArray.append(object.object(forKey: "title") as! String)
                    self.uuidArray.append(object.object(forKey: "uuid") as! String)
                }
                
                // reload tableView & end spinning of refresher
                /*
                self.tableView.reloadData()
                self.refresher.endRefreshing()
                 */
                
            } else {
                print(error!.localizedDescription)
            }
        })
 **/
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
    
    // cell numb
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return uuidArray.count
    }
    
    // cell config
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // define cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! feedCell
        
        // connect objects with our information from arrays
        cell.uuidLabel.text = uuidArray[indexPath.row]
        cell.descriptionTxt.text = titleArray[indexPath.row]
        cell.descriptionTxt.sizeToFit()
        
        // place post picture
        picArray[indexPath.row].getDataInBackground { (data, error) -> Void in
            cell.postImg.image = UIImage(data: data!)
        }
        return cell
    }
    
}
