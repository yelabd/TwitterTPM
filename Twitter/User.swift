//
//  User.swift
//  Twitter
//
//  Created by Youssef Elabd on 2/27/17.
//  Copyright © 2017 Youssef Elabd. All rights reserved.
//

import UIKit
import SwiftyJSON

class User: NSObject {
    
    static let userDidLogoutNotification = "UserDidLogout"

    var name: String = ""
    var screenname: String = ""
    var desc: String = ""
    var profileUrl: URL?
    var profileUrlStirng : String?
    var dictionary : NSDictionary?
    var backgroundUrlString: String?
    var backgroundUrl: URL?
    var userID: String?
    var followerCount: Int?
    var followingCount: Int?
    var tweetCount: Int?
    
    init(dictionary : NSDictionary){
        self.dictionary = dictionary
        self.name = (dictionary["name"] as? String)!
        self.desc = (dictionary["description"] as? String)!
        self.screenname = (dictionary["screen_name"] as? String)!
        self.profileUrlStirng = dictionary["profile_image_url_https"] as? String
        self.backgroundUrlString = dictionary["profile_background_image_url_https"] as? String
        self.userID = dictionary["id_str"] as? String
        self.tweetCount = dictionary["statuses_count"] as? Int
        self.followerCount = dictionary["followers_count"] as? Int
        self.followingCount = dictionary["friends_count"] as? Int
        
        if let backgroundUrlString = backgroundUrlString{
            self.backgroundUrl = URL(string: backgroundUrlString)
            print("Back ground url \(backgroundUrlString)")
        }
        
        if let profileUrlStirng = profileUrlStirng{
            print(profileUrlStirng)
            self.profileUrl = URL(string: profileUrlStirng)
        }
        
        print(self.name)
        print(self.desc)
        print(self.screenname)
    }
    static var _currentUser : User?
    class var currentUser: User? {
        get{
            if _currentUser == nil{
                let defaults = UserDefaults.standard
                
                let userData = defaults.value(forKey: "currentUserData")
                
                print(userData)
                
                if let userData = userData {
                    
                    let dictionary = try! JSONSerialization.jsonObject(with: userData as! Data, options: [])
                   
                    _currentUser = User(dictionary: dictionary as! NSDictionary)
                    //user = User()
                }
                
            }
            return _currentUser
        }
        set(user){
            _currentUser = user
            let defaults = UserDefaults.standard
            
            if let user = user{
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
                
                defaults.set(data,forKey: "currentUserData" )
            }else{
                defaults.set(nil, forKey: "currentUserData")
            }
            //defaults.setValue(user, forKey: "currentUserData")

//            defaults.setValue(value: user, forKey: "currentUser")
            
            defaults.synchronize()
        }
    }
}
