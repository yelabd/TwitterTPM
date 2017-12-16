//
//  LoginViewController.swift
//  Twitter
//
//  Created by Youssef Elabd on 2/26/17.
//  Copyright © 2017 Youssef Elabd. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class LoginViewController: UIViewController {
    
    var tweets: [Tweet] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        TwitterClient.sharedInstance?.homeTimeLine(success: { (tweets: [Tweet]) in
            self.tweets = tweets
            
            for tweet in tweets{
                print("hi \(tweet.timeStamp)")
            }
        }, failure: { (error: Error) in
            print(error.localizedDescription)
        })

        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLoginButton(_ sender: Any) {
        let client = TwitterClient.sharedInstance
        
        client?.login(success: { 
            print("login successful!!!")
            self.performSegue(withIdentifier: "loginSegue", sender: nil)
        }, failure: { (error: Error) in
            print(error.localizedDescription)
        })
        
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
