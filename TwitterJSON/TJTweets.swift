//
//  TJTweet.swift
//  TwitterJSON
//
//  Created by Kyle Goslan on 04/08/2015.
//  Copyright (c) 2015 Kyle Goslan. All rights reserved.
//

import Foundation
import SwiftyJSON

public protocol TJTweetDelegate {
    func gotTweets(tweets:[TJTweet])
}

public class TJTweets {
    
    public let twitterJSON: TwitterJSON!
    public var delegate: TJTweetDelegate?
    
    public init(apiKey: String, apiSecret: String) {
        self.twitterJSON = TwitterJSON(apiKey: apiKey, apiSecret: apiSecret)
        self.twitterJSON.delegate = self
    }
    
    public func getTimelineForUser(screenName: String) {
        twitterJSON.getBearerToken { (bearerToken) -> Void in
            let apiURL = "https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=" + screenName
            self.twitterJSON.performDataRequestForURL(apiURL, bearerToken: bearerToken)
        }
    }
    
    public func getFavorites(screenName: String) {
        twitterJSON.getBearerToken { (bearerToken) -> Void in
            let apiURL = "https://api.twitter.com/1.1/favorites/list.json?screen_name=" + screenName
            self.twitterJSON.performDataRequestForURL(apiURL, bearerToken: bearerToken)
        }
    }

}

extension TJTweets: TwitterJSONDelegate {
    public func gotdata(data: JSON) {
        
        var tweets = [TJTweet]()
        
        for item in data {
            let tweet = TJTweet(tweetInfo: item.1)
            tweets.append(tweet)
        }
        
        self.delegate?.gotTweets(tweets)
    }
}