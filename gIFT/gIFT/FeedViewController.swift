//
//  FeedViewController.swift
//  gIFT
//
//  Created by Brian Li on 11/11/17.
//  Copyright © 2017 gIFT. All rights reserved.
//

import UIKit
import Stripe

class FeedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        handleAddPayment()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension FeedViewController: STPAddCardViewControllerDelegate {
    
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
