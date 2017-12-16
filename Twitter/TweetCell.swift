//
//  TweetCell.swift
//  Twitter
//
//  Created by Youssef Elabd on 2/28/17.
//  Copyright © 2017 Youssef Elabd. All rights reserved.
//

import UIKit
import AFNetworking

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var favoriteImageView: UIButton!
    @IBOutlet weak var favoriteLabel: UILabel!
    @IBOutlet weak var retweetLabel: UILabel!
    
    var tweet : Tweet!{
        didSet{
            descLabel.text = tweet.text
            usernameLabel.text = tweet.username
            profileImageView.setImageWith(tweet.profileUrl!)
            favoriteLabel.text = String(tweet.favoriteCount)
            retweetLabel.text = String(tweet.retweetCount)
//            var dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "MMM-d"
            //var dateString = dateFormatter.string(from: tweet.timeStamp!)
            //timeLabel.text = dateString
            
            //print(tweet.timeStamp)
            handleLabel.text = "@\(tweet.handle)"
            
            
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        profileImageView.layer.cornerRadius = 3
        profileImageView.clipsToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
