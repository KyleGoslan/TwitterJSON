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
Object that deals with sending requets to the Twitter api to do with retrieving Tweets.
When methods are called they return an array of TJTweet objects to the delegate method.
*/
public class TJTweets {
    
    private let twitterJSON: TwitterJSON!
    
    public init(apiKey: String, apiSecret: String) {
        self.twitterJSON = TwitterJSON(apiKey: apiKey, apiSecret: apiSecret)
    }
    
    /**
    Gets the most recent tweets of the user specified in the parameter. Once the results are retrieved
    they are passed to the delegate method as an array of TJTweet objects.
    
    :param: String Screen name of the users whos timeline to retrieve.
    */
    public func getTimelineForUser(screenName: String, completion: (tweets: [TJTweet]) -> Void) {
        twitterJSON.getBearerToken { (bearerToken) -> Void in
            let apiURL = "https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=" + screenName
            self.twitterJSON.performDataRequestForURL(apiURL, bearerToken: bearerToken, completion: { data in
                var tweets = [TJTweet]()
                for item in data {
                    let tweet = TJTweet(tweetInfo: item.1)
                    tweets.append(tweet)
                }
                completion(tweets: tweets)
            })
        }
    }
    
    /**
    Gets the most recent favorited tweets of the user specified in the parameter. Once the results are retrieved
    they are passed to the delegate method as an array of TJTweet objects.
    
    :param: String Screen name of the users whos favorites to retrieve.
    */
    public func getFavorites(screenName: String, completion: (tweets: [TJTweet]) -> Void) {
        twitterJSON.getBearerToken { (bearerToken) -> Void in
            let apiURL = "https://api.twitter.com/1.1/favorites/list.json?screen_name=" + screenName
            self.twitterJSON.performDataRequestForURL(apiURL, bearerToken: bearerToken, completion: { data in
                var tweets = [TJTweet]()
                for item in data {
                    let tweet = TJTweet(tweetInfo: item.1)
                    tweets.append(tweet)
                }
                completion(tweets: tweets)
            })
        }
    }
    
}