//
//  ProfileViewController.swift
//  Twitter
//
//  Created by Youssef Elabd on 3/6/17.
//  Copyright © 2017 Youssef Elabd. All rights reserved.
//

import UIKit
import AFNetworking

class ProfileViewController: UIViewController, UITableViewDelegate,UITableViewDataSource{
    
    var user : User?
    var allTweets: [Tweet] = []
    
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var tweetCount: UILabel!
    @IBOutlet weak var followingCount: UILabel!
    @IBOutlet weak var followerCount: UILabel!

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
        
        TwitterClient.sharedInstance?.currentAccount(success: { (user: User) in
            self.user = user
            self.bgImageView.setImageWith((self.user?.profileUrl)!)
            self.frontImageView.setImageWith((self.user?.profileUrl)!)
            self.nameLabel.text = self.user?.name
            self.handleLabel.text = "@\(self.user!.screenname)"
            self.tweetCount.text = String(describing: user.tweetCount!)
            self.followingCount.text = String(describing: user.followingCount!)
            self.followerCount.text = String(describing: user.followerCount!)
            
            print(user.name)
            
        }, failure: { (error: Error) in
            print(error.localizedDescription)
        })
        
        TwitterClient.sharedInstance?.currentTimeLine(success: { (tweets: [Tweet]) in
            print("Hi")
            self.allTweets = tweets
            print(self.allTweets.count)
            self.tableView.reloadData()
        }, failure: { (error: Error) in
            print(error.localizedDescription)
        })
        
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width, height: scrollView.bounds.height*1.2
        )

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
