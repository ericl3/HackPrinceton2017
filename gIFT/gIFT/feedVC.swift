//
//  feedVC.swift
//  hackprinceton
//
//  Created by Grant Kim on 11/12/17.
//  Copyright © 2017 Grant Kim. All rights reserved.
//

import UIKit
import Parse
import Stripe

//var postuuid = [String]()

class feedVC: UITableViewController {

    // comment out uuid for now
    // hold info from server
    var usernameArray = [String]()
    var picArray = [PFFile]()
    var titleArray = [String]()
    var uuidArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        //let subView = ButtonsVC().view
        //self.navigationController?.view.addSubview(subView!)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if(Global.firstAccess) {
            handleAddPayment()
            Global.firstAccess = false
        }
    }
    
    func loadData() {
        print("Attempting to access data")
        // dynamic cell length
        //self.tableView.rowHeight = UITableViewAutomaticDimension
        //tableView.estimatedRowHeight = 450
        
        let postQuery = PFQuery(className: "posts")
        //postQuery.whereKey("uuid", equalTo: postuuid.last!)
        postQuery.findObjectsInBackground(block: { (objects, error) -> Void in
            if error == nil {
                
                // clean up
                self.usernameArray.removeAll(keepingCapacity: false)
                self.picArray.removeAll(keepingCapacity: false)
                self.titleArray.removeAll(keepingCapacity: false)
                //self.uuidArray.removeAll(keepingCapacity: false)
                
                // find related objects
                for object in objects! {
                    print("access")
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
                dump(self.titleArray)
                
                self.tableView.reloadData()
                
            } else {
                print(error!.localizedDescription)
            }
        })
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    // cell numb
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return uuidArray.count
        return titleArray.count
    }
    
    // cell config
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // define cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! feedCell
        
        // connect objects with our information from arrays
        cell.nameTxt.text = usernameArray[indexPath.row]
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

extension feedVC: STPAddCardViewControllerDelegate {
    
    func handleAddPayment() {
        // Setup add card view controller
        let addCardViewController = STPAddCardViewController()
        addCardViewController.delegate = self
        
        // Present add card view controller
        let navigationController = UINavigationController(rootViewController: addCardViewController)
        present(navigationController, animated: true)
    }
    
    // MARK: STPAddCardViewControllerDelegate
    
    func addCardViewControllerDidCancel(_ addCardViewController: STPAddCardViewController) {
        // Dismiss add card view controller
        dismiss(animated: true)
    }
    
    func addCardViewController(_ addCardViewController: STPAddCardViewController, didCreateToken token: STPToken, completion: @escaping STPErrorBlock) {
        
        submitTokenToBackend(token: token, completion: { (error: Error?) in
            if let error = error {
                // Show error in add card view controller
                completion(error)
            }
            else {
                // Notify add card view controller that token creation was handled successfully
                completion(nil)
                
                print("did work!!!!")
                // Dismiss add card view controller
                dismiss(animated: true)
            }
        })
        
    }
    
    func submitTokenToBackend(token: STPToken, completion: (Error?) -> ()) {
        let requestURL = "https://BrianLi101.lib.id/testgIFT@dev/"
        let request = NSMutableURLRequest(url: NSURL(string: requestURL)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "POST"
        let body = ["stripeToken": token.tokenId]
        let seralization = try? JSONSerialization.data(withJSONObject: body, options: [])
        print(seralization)
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error)
            } else {
                if let data = data {
                    do {
                        let collectionObject = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [String: AnyObject]
                        dump(collectionObject)
                        // assume that the payment was completed properly as long as JSON data is returned from the network request to Stripe via stdlib
                        self.dismiss(animated: true)
                    }
                    catch let parseError {
                        print(parseError)
                        print(parseError.localizedDescription)
                        
                    }
                } else {
                    return
                }
            }
        })
        
        dataTask.resume()
        return
    }
}

