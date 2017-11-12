//
//  feedCell.swift
//  hackprinceton
//
//  Created by Grant Kim on 11/12/17.
//  Copyright © 2017 Grant Kim. All rights reserved.
//

import UIKit

class feedCell: UITableViewCell {

    @IBOutlet weak var nameTxt: UILabel!
    @IBOutlet weak var postImg: UIImageView!
    @IBOutlet weak var descriptionTxt: UILabel!
    @IBOutlet weak var uuidLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(feedCell.doubleTapped))
        tapGesture.delegate = self
        tapGesture.numberOfTapsRequired = 2
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc func doubleTapped() {
        print("double tapped")
        if(Global.firstAccess == true) {
            Global.firstAccess = false
            if var topController = UIApplication.shared.keyWindow?.rootViewController {
                topController.performSegue(withIdentifier: "MAKEPAYMENT", sender: nil)
            }
           
        }
        
        let gift = UIImage(contentsOfFile: "gift.png")
        let giftView = UIImageView(image: gift)
        giftView.frame = postImg.frame
        giftView.center = postImg.center
        postImg.addSubview(giftView)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
