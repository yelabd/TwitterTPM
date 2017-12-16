//
//  Tweet.swift
//  Twitter
//
//  Created by Youssef Elabd on 2/27/17.
//  Copyright © 2017 Youssef Elabd. All rights reserved.
//

import UIKit
import SwiftyJSON

class Tweet: NSObject {
    
    var text: String = ""
    var timeStamp: Date?
    var retweetCount: Int = 0
    var favoriteCount: Int = 0
    var username : String = ""
    var handle : String = ""
    var profileUrlString : String?
    var profileUrl : URL?
    var id : String?
    
    
    init(json : JSON){
        
        self.text = json["text"].stringValue
        
        self.retweetCount = json["retweet_count"].intValue 
        self.favoriteCount = json["favorite_count"].intValue
        
        let timeStampString = json["created_at"].stringValue
        
        let formatter = DateFormatter()
        
        formatter.dateFormat = "EEE MMM d HH:MM:ss Z y"
        
        self.timeStamp = formatter.date(from: timeStampString)
        
        
        self.username = json["user"]["name"].stringValue
        self.handle = json["user"]["screen_name"].stringValue
        self.id = json["user"]["id_str"].stringValue
        
        self.profileUrlString = json["user"]["profile_image_url_https"].stringValue
        //print(profileUrlString)
        
        if let profileUrlStirng = profileUrlString{
            print(profileUrlStirng)
            self.profileUrl = URL(string: profileUrlStirng)
        }

        
    }
    
    class func tweetsWithArray(jsons : [JSON]) -> [Tweet]{
        var tweets : [Tweet] = []
        
        for json in jsons{
            let tweet = Tweet(json: json)
            tweets.append(tweet)
        }
        
        return tweets
        
        }

}

