//
//  postVC.swift
//  hackprinceton
//
//  Created by Grant Kim on 11/12/17.
//  Copyright © 2017 Grant Kim. All rights reserved.
//

import UIKit

class postVC: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextViewDelegate {

    @IBOutlet weak var descriptionTxt: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // declare select image tap
        
        // calls load image when the image is tapped
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(postVC.loadImg(_:)))
        imageTap.numberOfTapsRequired = 1
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(imageTap)
        
        // check notifications if keyboard is shown or not
        NotificationCenter.default.addObserver(self, selector: #selector(postVC.showKeyboard(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(postVC.hideKeyboardTap(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        // declare hide kyboard tap
        let hideTap = UITapGestureRecognizer(target: self, action: #selector(postVC.hideKeyboardTap(_:)))
        hideTap.numberOfTapsRequired = 1
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(hideTap)
 
 
 }
    
    @IBAction func cancelClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    // allows user to select image from their photo library
    @objc func loadImg(_ recognizer:UITapGestureRecognizer) {
        let picker = UIImagePickerController()
        picker.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    // connect selected image to our ImageView
    // also potential delete
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print("entered method")
        imageView.image = info[UIImagePickerControllerEditedImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
    // hide keyboard if tapped
    @objc func hideKeyboardTap(_ recoginizer:UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    // show keyboard
    @objc func showKeyboard(_ notification:Notification) {
        
        // define keyboard size
        _ = ((notification.userInfo?[UIKeyboardFrameEndUserInfoKey]! as AnyObject).cgRectValue)!
        
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        self.view.endEditing(true)
        return true
    }

    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
