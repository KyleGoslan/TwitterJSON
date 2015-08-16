//
//  TJTweet.swift
//  TwitterJSON
//
//  Created by Kyle Goslan on 04/08/2015.
//  Copyright (c) 2015 Kyle Goslan. All rights reserved.
//

import Foundation
import SwiftyJSON

/**
A single tweet object.

This also contains a TJUser which contains information about the user who posted the tweet.
*/
public class TJTweet {
    
    /**
    The user who the tweet belongs to
    */
    public var user: TJUser!
    
    /**
    The main 140 characters text of the tweet
    */
    public var text: String!
    
    /**
    The ID of the tweet
    */
    public var id: Int!
    
    /**
    How many times the tweet has been favorited
    */
    public var favoriteCount: Int!
    
    /**
    How many times the tweet has been retweeted
    */
    public var retweetCount: Int!
    
    /**
    Array of hashtags in the tweet
    */
    public var hashtags: [String] = []
    
    /**
    Array of urls in the tweet
    */
    public var urls: [String] = []
    
    /**
    Array of users mentioned in the tweet
    */
    public var userMentions: [String] = []
    
    /**
    Initilize with a json object.
    
    The init method parses the json and sets the objets properties.
    */
    init(tweetInfo: JSON) {
        
        if let id = tweetInfo["id"].int {
            self.id = id
        }
        
        if let user = tweetInfo["user"].dictionary {
            self.user = TJUser(userInfo: tweetInfo["user"])
        }
        
        if let text = tweetInfo["text"].string {
            self.text = text
        }
        
        if let favoriteCount = tweetInfo["favorite_count"].int {
            self.favoriteCount = favoriteCount
        }
        
        if let retweetCount = tweetInfo["retweet_count"].int {
            self.retweetCount = retweetCount
        }
        
        if let hashtags = tweetInfo["entities","hashtags"].array {
            for tag in hashtags {
                self.hashtags.append(tag["text"].string!)
            }
        }
        
        if let urls = tweetInfo["entities","urls"].array {
            for url in urls {
                self.urls.append(url["expanded_url"].string!)
            }
        }
        
        if let userMentions = tweetInfo["entities","user_mentions"].array {
            for mention in userMentions {
                self.userMentions.append(mention["screen_name"].string!)
            }
        }

    }
    
}







