//
//  GetTweets.swift
//  TwitterJSON
//
//  Created by Kyle Goslan on 14/08/2015.
//  Copyright (c) 2015 Kyle Goslan. All rights reserved.
//

import Foundation

/**
Methods that deal with returning an array of tweets are in this file.
*/
extension TwitterJSON {
    
    /**
    Search for tweets.
    
    :param: String The search term to query.
    :param: Completion Containts an array of TJTweet objects.
    */
    public class func searchForTweets(query: String, completion: (tweets: [TJTweet]) -> Void) {
        let apiURL = "https://api.twitter.com/1.1/search/tweets.json"
        let parameters = [
            "q" : query,
            "count": "\(TwitterJSON.numberOfResults)"
        ]
        TwitterJSON.makeRequest(.GET, parameters: parameters, apiURL: apiURL) { success, json in
            var tweets = [TJTweet]()
            for item in json["statuses"] {
                let tweet = TJTweet(tweetInfo: item.1)
                tweets.append(tweet)
            }
            TwitterJSON.loadImages(tweets, users: nil, completion: { (tweets, users) -> Void in
                dispatch_async(dispatch_get_main_queue(),{
                    completion(tweets: tweets!)
                })
            })
        }
    }
    
    /**
    Get the logged in users main feed.
    
    :param: Completion Containts an array of TJTweet objects.
    */
    public class func getHomeFeed(completion: (tweets: [TJTweet]) -> Void) {
        let apiURL = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        let parameters = [
            "count": "\(TwitterJSON.numberOfResults)"
        ]
        TwitterJSON.makeRequest(.GET, parameters: parameters, apiURL: apiURL) { success, json in
            var tweets = [TJTweet]()
            for item in json {
                let tweet = TJTweet(tweetInfo: item.1)
                tweets.append(tweet)
            }
            TwitterJSON.loadImages(tweets, users: nil, completion: { (tweets, users) -> Void in
                dispatch_async(dispatch_get_main_queue(),{
                    completion(tweets: tweets!)
                })
            })
        }
    }
    
}