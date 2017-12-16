//
//  TwitterClient.swift
//  Twitter
//
//  Created by Youssef Elabd on 2/27/17.
//  Copyright © 2017 Youssef Elabd. All rights reserved.
//

import UIKit
import BDBOAuth1Manager
import SwiftyJSON

class TwitterClient: BDBOAuth1SessionManager {
    
    var userID: Int?
        
    static let sharedInstance = TwitterClient(baseURL: URL(string: "https://api.twitter.com")!, consumerKey: "ITAlNcYUNcl1lcDbkI2PeJB53", consumerSecret: "RPRDAzafa2hz5s3LD81uYnBX2cDaSz0CYxGwk99UstOot44yh2")
    
    func homeTimeLine(success: @escaping ([Tweet]) -> (), failure: @escaping (Error) -> ()){
        get("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask,response: Any?) in
            //print(response!)
            let json = JSON(response!).arrayValue
            
            let tweets = Tweet.tweetsWithArray(jsons: json)
            
            success(tweets)
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            failure(error)
        })

    }
    
    func currentAccount(success: @escaping (User) -> (),failure: @escaping (Error) -> ()){
        get("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask,response: Any?) in
            //print(response!)
            let dictionary = response as! NSDictionary
            
            //let json = JSON(response!)
            let user = User(dictionary: dictionary)
            
            success(user)
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            failure(error)
        })

    }
    
//    func getAccount(id: String,success: @escaping (User) -> (),failure: @escaping (Error) -> ()){
//        get("1.1/users/lookup.json", parameters: ["user_id":id], progress: nil, success: { (task: URLSessionDataTask,response: Any?) in
//            print(response!)
//            let dictionary = response as! NSArray
//            
//            let dictionary1: NSDictionary? = nil
//            //let json = JSON(response!)
//            let user = User(dictionary: dictionary1!)
//            
//            success(user)
//        }, failure: { (task: URLSessionDataTask?, error: Error) in
//            failure(error)
//        })
//        
//    }

    
    func currentTimeLine(success: @escaping ([Tweet]) -> (), failure: @escaping (Error) -> ()){
        get("1.1/statuses/user_timeline.json", parameters: ["user_id": getUserID()], progress: nil, success: { (task: URLSessionDataTask,response: Any?) in
            //print(response!)
            let json = JSON(response!).arrayValue
            
            let tweets = Tweet.tweetsWithArray(jsons: json)
            
            print("SUcccccsndf;kZDNf")
            for tweet in tweets{
                print(tweet.text)
            }
            
            success(tweets)
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            failure(error)
            
        })
        
    }
    
    func userTimeLine(id: String,success: @escaping ([Tweet]) -> (), failure: @escaping (Error) -> ()){
        get("1.1/statuses/user_timeline.json", parameters: ["user_id": id], progress: nil, success: { (task: URLSessionDataTask,response: Any?) in
            //print(response!)
            let json = JSON(response!).arrayValue
            
            let tweets = Tweet.tweetsWithArray(jsons: json)
            
            print("SUcccccsndf;kZDNf")
            for tweet in tweets{
                print(tweet.text)
            }
            
            success(tweets)
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            failure(error)
            
        })
        
    }

    
    func getUserID() -> String{
        var id = ""
        currentAccount(success: { (user: User) in
            id = user.userID!
        }) { (error: Error) in
            print(error.localizedDescription)
            print("jdfgajfnvzjs")
        }
        
        return id
    }

    
    var loginSuccess: (() -> ())?
    var loginFailure: ((Error) -> ())?
    
    func login(success: @escaping () -> (),failure: @escaping (Error) -> ()){
        loginSuccess = success
        loginFailure = failure
        TwitterClient.sharedInstance!.deauthorize()
        
        //let tempURL = URL(string: "https://google.com")!
        
        TwitterClient.sharedInstance!.fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: URL(string: "twitterClone://oauth") , scope: nil, success: { (requestToken: BDBOAuth1Credential?) -> Void in
            print("token obtained")
            print(requestToken!.token)
            let token = requestToken!.token
            
            let url = URL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(token!)")
            //let url = URL(string: "https://google.com")
            UIApplication.shared.open(url!, options: [:], completionHandler: nil)
            
        }, failure: { (error : Error?) -> Void in
            print(error!.localizedDescription)
            self.loginFailure?(error!)
        })

    }
    
    func logout(){
        User.currentUser = nil
        deauthorize()
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: User.userDidLogoutNotification),object: nil)
    }
    
    func handleOpenUrl(url: URL){
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        
        fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken: BDBOAuth1Credential?) in
            print("Access token obtained")
            
            
//            client.homeTimeLine(success: { (tweets: [Tweet]) in
//                for tweet in tweets{
//                    print(tweet.text)
//                }
//            }, failure: { (error : Error) in
//                print(error.localizedDescription)
//            })
            
            self.currentAccount(success: { (user: User) in
                User.currentUser = user
                self.loginSuccess?()

            }, failure: { (error: Error) in
                self.loginFailure?(error)

            })
            
            
            
        }, failure: { (error: Error?) in
            print(error?.localizedDescription)
            self.loginFailure?(error!)
        })

    }


}
