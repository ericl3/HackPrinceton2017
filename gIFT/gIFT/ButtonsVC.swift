//
//  ButtonsVC.swift
//  gIFT
//
//  Created by Vicki Lu on 11/12/17.
//  Copyright © 2017 gIFT. All rights reserved.
//

import UIKit

class ButtonsVC: UIViewController {

    @IBOutlet weak var menu: UIButton!
    @IBOutlet weak var comment: UIButton!
    @IBOutlet weak var gift: UIButton!
    @IBOutlet weak var send: UIButton!
    
    @IBOutlet weak var search: UIButton!
    @IBOutlet weak var post: UIButton!
    @IBOutlet weak var settings: UIButton!
    @IBOutlet weak var profile: UIButton!
    @IBOutlet weak var money: UIButton!
    
    
    var commentButtonCenter: CGPoint!
    var giftButtonCenter: CGPoint!
    var sendButtonCenter: CGPoint!
    var searchButtonCenter: CGPoint!
    var postButtonCenter: CGPoint!
    var settingsButtonCenter: CGPoint!
    var profileButtonCenter: CGPoint!
    var moneyButtonCenter: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        comment.isHidden = true
        gift.isHidden = true
        send.isHidden = true
        search.isHidden = true
        post.isHidden = true
        settings.isHidden = true
        profile.isHidden = true
        money.isHidden = true
        
        commentButtonCenter = comment.center
        giftButtonCenter = gift.center
        sendButtonCenter = send.center
        searchButtonCenter = search.center
        postButtonCenter = post.center
        settingsButtonCenter = settings.center
        profileButtonCenter = profile.center
        moneyButtonCenter = money.center
        
        comment.center = menu.center
        gift.center = menu.center
        send.center = menu.center
        search.center = menu.center
        post.center = menu.center
        settings.center = menu.center
        profile.center = menu.center
        money.center = menu.center
    }

    @IBAction func menuClicked(_ sender: UIButton) {
        if menu.currentImage == #imageLiteral(resourceName: "control_off") {//expand buttons
            UIView.animate(withDuration: 0.3, animations: {
                self.comment.isHidden = false
                self.gift.isHidden = false
                self.send.isHidden = false
                self.search.isHidden = false
                self.post.isHidden = false
                self.settings.isHidden = false
                self.profile.isHidden = false
                self.money.isHidden = false
                
                self.comment.center = self.commentButtonCenter
                self.gift.center = self.giftButtonCenter
                self.send.center = self.sendButtonCenter
                self.search.center = self.searchButtonCenter
                self.post.center = self.postButtonCenter
                self.settings.center = self.settingsButtonCenter
                self.profile.center = self.profileButtonCenter
                self.money.center = self.moneyButtonCenter

                })
        }else{//collapse buttons
            UIView.animate(withDuration: 0.3, animations: {

                self.comment.center = self.menu.center
                self.gift.center = self.menu.center
                self.send.center = self.menu.center
                self.search.center = self.menu.center
                self.post.center = self.menu.center
                self.settings.center = self.menu.center
                self.profile.center = self.menu.center
                self.money.center = self.menu.center
            
          
                self.comment.isHidden = true
                self.gift.isHidden = true
                self.send.isHidden = true
                self.search.isHidden = true
                self.post.isHidden = true
                self.settings.isHidden = true
                self.profile.isHidden = true
                self.money.isHidden = true
            })
        }
        toggleButton(button: sender, onImage: #imageLiteral(resourceName: "control_on"), offImage: #imageLiteral(resourceName: "control_off"))
    }
    
    @IBAction func commentClicked(_ sender: UIButton) {
        toggleButton(button: sender, onImage: #imageLiteral(resourceName: "comment_on"), offImage: #imageLiteral(resourceName: "comment_off"))
        
        if comment.currentImage == #imageLiteral(resourceName: "comment_on") {//expand buttons
            UIView.animate(withDuration: 0.3, animations: {
                self.search.isHidden = true
                self.post.isHidden = true
                self.settings.isHidden = true
                self.profile.isHidden = true
                self.money.isHidden = true
            })
        }
        else{
                UIView.animate(withDuration: 0.3, animations: {
                    self.search.isHidden = false
                    self.post.isHidden = false
                    self.settings.isHidden = false
                    self.profile.isHidden = false
                    self.money.isHidden = false
                })
            }
        }
    

    @IBAction func giftClicked(_ sender: UIButton) {
        toggleButton(button: sender, onImage: #imageLiteral(resourceName: "gift_on"), offImage: #imageLiteral(resourceName: "gift_off"))
        
        if gift.currentImage == #imageLiteral(resourceName: "gift_on") {//expand buttons
            UIView.animate(withDuration: 0.3, animations: {
                self.search.isHidden = true
                self.post.isHidden = true
                self.settings.isHidden = true
                self.profile.isHidden = true
                self.money.isHidden = true
            })
        }
        else{
            UIView.animate(withDuration: 0.3, animations: {
                self.search.isHidden = false
                self.post.isHidden = false
                self.settings.isHidden = false
                self.profile.isHidden = false
                self.money.isHidden = false
            })
        }
    }
    
    @IBAction func sendClicked(_ sender: UIButton) {
         toggleButton(button: sender, onImage: #imageLiteral(resourceName: "send_on"), offImage: #imageLiteral(resourceName: "send_off"))
        
        if send.currentImage == #imageLiteral(resourceName: "send_on"){//expand buttons
            UIView.animate(withDuration: 0.3, animations: {
                self.search.isHidden = true
                self.post.isHidden = true
                self.settings.isHidden = true
                self.profile.isHidden = true
                self.money.isHidden = true
            })
        }
        else{
            UIView.animate(withDuration: 0.3, animations: {
                self.search.isHidden = false
                self.post.isHidden = false
                self.settings.isHidden = false
                self.profile.isHidden = false
                self.money.isHidden = false
            })
        }
    }
    
    func toggleButton(button: UIButton, onImage: UIImage, offImage: UIImage){
        if button.currentImage == offImage {
            button.setImage(onImage, for: .normal)
        }else{
            button.setImage(offImage, for: .normal)
        }
    }
    
}
