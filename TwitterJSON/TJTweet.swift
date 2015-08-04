//
//  TJTweet.swift
//  TwitterJSON
//
//  Created by Kyle Goslan on 04/08/2015.
//  Copyright (c) 2015 Kyle Goslan. All rights reserved.
//

import Foundation
import SwiftyJSON

public class TJTweet {
    
    //The user who the tweet belongs to
    public var user: TJUser!
    
    //The main body of the tweet
    public var text: String!
    
    //How many times the tweet has been favorited
    public var favoriteCount: Int!
    
    init(tweetInfo: JSON) {
        
        if let user = tweetInfo["user"].dictionary {
            self.user = TJUser(userInfo: tweetInfo["user"])
        }
        
        if let text = tweetInfo["text"].string {
            self.text = text
        }
        
        if let favoriteCount = tweetInfo["favorite_count"].int {
            self.favoriteCount = favoriteCount
        }
        
    }
    
}