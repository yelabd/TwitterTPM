//
//  IndvProfileViewController.swift
//  Twitter
//
//  Created by Youssef Elabd on 3/7/17.
//  Copyright © 2017 Youssef Elabd. All rights reserved.
//

import UIKit
import AFNetworking

class IndvProfileViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    var tweet: Tweet?
    var allTweets: [Tweet] = []
    
    
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var followerLabel: UILabel!
    
    @IBOutlet weak var frontImageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 150
        
        let darkBlur = UIBlurEffect(style: UIBlurEffectStyle.light)
        let blurView = UIVisualEffectView(effect: darkBlur)
        blurView.frame = bgImageView.bounds
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        bgImageView.addSubview(blurView)
        
        frontImageView.layer.cornerRadius = 3
        frontImageView.clipsToBounds = true
        frontImageView.layer.borderWidth = 2
        frontImageView.layer.borderColor = UIColor.white.cgColor
        
        self.nameLabel.text = tweet?.username
        self.handleLabel.text = tweet?.handle
        self.bgImageView.setImageWith((tweet?.profileUrl)!)
        self.frontImageView.setImageWith((tweet?.profileUrl)!)
        
         scrollView.contentSize = CGSize(width: scrollView.frame.size.width, height: scrollView.bounds.height*1.2)

        
        TwitterClient.sharedInstance?.userTimeLine(id: (tweet?.id)!, success: { (tweets: [Tweet]) in
            self.allTweets = tweets
            self.tableView.reloadData()
        }, failure: { (error: Error) in
            print(error.localizedDescription)
        })
        
//        TwitterClient.sharedInstance?.getAccount(id: (tweet?.id)!, success: { (user: User) in
//            self.tweetLabel.text = String(describing: user.tweetCount!)
//            self.followingLabel.text = String(describing: user.followingCount!)
//            self.followerLabel.text = String(describing: user.followerCount!)
//        }, failure: { (error: Error) in
//            print(error.localizedDescription)
//        })

        // Do any additional setup after loading the view.
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
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        
        return self.allTweets.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        
        let row = indexPath.row
        
        let tweetInfo = self.allTweets[row]
        cell.tweet = tweetInfo
        
        return cell
        
    }


}
