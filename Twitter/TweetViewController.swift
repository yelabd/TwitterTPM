//
//  TweetViewController.swift
//  Twitter
//
//  Created by Youssef Elabd on 3/5/17.
//  Copyright © 2017 Youssef Elabd. All rights reserved.
//

import UIKit
import AFNetworking

class TweetViewController: UIViewController {

    
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var likeImageView: UIButton!
    var tweet : Tweet?
    
    @IBOutlet weak var retweetButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        likeLabel.text = String(describing: tweet!.favoriteCount)
        print(tweet!.username)
        
        retweetLabel.text = String(describing: tweet!.retweetCount)
        
        posterView.setImageWith((tweet?.profileUrl)!)
        nameLabel.text = tweet?.username
        handleLabel.text = tweet?.handle
        textLabel.text = tweet?.text
        
        posterView.layer.cornerRadius = 3
        posterView.clipsToBounds = true
        
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLike(_ sender: Any) {
        likeImageView.setImage(UIImage(named: "favor-icon-red"), for: .normal)
        tweet?.favoriteCount = (tweet?.favoriteCount)! + 1
    
        likeLabel.text = String(describing: tweet!.favoriteCount)
    }

    @IBAction func onRetweet(_ sender: Any) {
        retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: .normal)
        tweet?.retweetCount = (tweet?.retweetCount)! + 1
        
        retweetLabel.text = String(describing: tweet!.retweetCount)
    

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
