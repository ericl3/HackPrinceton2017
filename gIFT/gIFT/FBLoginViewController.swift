//
//  FBLoginViewController.swift
//  gIFT
//
//  Created by Brian Li on 11/11/17.
//  Copyright © 2017 gIFT. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Parse

class FBLoginViewController: UIViewController, FBSDKLoginButtonDelegate {
    @IBOutlet var loginButton: FBSDKLoginButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view, typically from a nib.

        if (FBSDKAccessToken.current() != nil) {
            // User is logged in, do work such as go to next view controller.
            print("should immediately login")
            // login()
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // login()
    }

    func login() {
        loginButton.isHidden = true
        
        performSegue(withIdentifier: "LOGIN", sender: nil)
        
        let userID = FBSDKAccessToken.current().userID
        print("the user id is" + userID!)
        
        var query = PFQuery(className: "_User")
        query.whereKey("Username", equalTo: userID)
        query.findObjectsInBackground { (objects, error) in
            if(error == nil) {
                if(objects!.count > 0) {
                    print("user found")
                } else {
                    print("new user")
                    let user = PFUser()
                    user.username = userID
                    user.password = "dummy"
                    Global.userID = userID!
                    user.signUpInBackground { (success, error) -> Void in
                        if success {
                            print("registered")
                            UserDefaults.standard.set(user.username, forKey: "username")
                            UserDefaults.standard.set(user.password, forKey: "password")
                            UserDefaults.standard.synchronize()
                            let appDelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
                            appDelegate.login()
                        }else{
                            print(error?.localizedDescription)
                        }
                        
                    }
                }
            } else {
                print("there is an error")
            }
        }

        
        PFUser.logInWithUsername(inBackground: userID!, password: "") { (user, error) -> Void in
            if error == nil {
                
                // remember user or save in App Memeory did the user login or not
                UserDefaults.standard.set(user!.username, forKey: "username")
                UserDefaults.standard.synchronize()
                print("account found")
                
                // call login function from AppDelegate.swift class
                let appDelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.login()
                
            } else {
                // show alert message
                let alert = UIAlertController(title: "Error", message: error!.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
            }
        }
        
    }
    

    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if(error == nil) {
            if(FBSDKAccessToken.current() != nil) {
                login()
            }
        }
      
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
    }
}

