//
//  TwitterJSON.swift
//  TwitterJSON
//
//  Created by Kyle Goslan on 04/08/2015.
//  Copyright (c) 2015 Kyle Goslan. All rights reserved.
//

import Foundation
import SwiftyJSON
import Accounts
import Social

/**
All the real network requests are sent through this object.
*/
public class TwitterJSON {
    
    public static var numberOfTweets = 25
    
    /**
    Search for tweets.
    
    :param: String The search term to query.
    :param: Completion Containts an array of TJTweet objects.
    */
    public class func searchForTweets(query: String, completion: (tweets: [TJTweet]) -> Void) {
        let apiURL = "https://api.twitter.com/1.1/search/tweets.json"
        let parameters = [
            "q" : query,
            "count": "\(TwitterJSON.numberOfTweets)"
        ]
        TwitterJSON.makeRequest(.GET, parameters: parameters, apiURL: apiURL) { success, json in
            var tweets = [TJTweet]()
            for item in json["statuses"] {
                let tweet = TJTweet(tweetInfo: item.1)
                tweets.append(tweet)
            }
            dispatch_async(dispatch_get_main_queue(),{
                completion(tweets: tweets)
            })
        }
    }
    
    /**
    Get the logged in users main feed.
    
    :param: Completion Containts an array of TJTweet objects.
    */
    public class func getHomeFeed(completion: (tweets: [TJTweet]) -> Void) {
        let apiURL = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        TwitterJSON.makeRequest(.GET, parameters: nil, apiURL: apiURL) { success, json in
            var tweets = [TJTweet]()
            for item in json {
                let tweet = TJTweet(tweetInfo: item.1)
                tweets.append(tweet)
            }
            dispatch_async(dispatch_get_main_queue(),{
                completion(tweets: tweets)
            })
        }
    }
    
    /**
    Create a new tweet.
    
    :param: String Text to post.
    :param: Completion Contains a sussess bool.
    */
    public class func postTweet(text: String, completion: (success: Bool) -> Void) {
        let apiURL = "https://api.twitter.com/1.1/statuses/update.json"
        let parameters = [
            "status" : text.stringByReplacingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        ]
        TwitterJSON.makeRequest(.POST, parameters: parameters, apiURL: apiURL) { success, _ in
            dispatch_async(dispatch_get_main_queue(),{
                completion(success: success)
            })
        }
    }
    
    /**
    Retweet a tweet.
    
    :param: Int The ID of the tweet to retweet.
    :param: Completion Contains a sussess bool. Success will be true if the user has already retweeted the tweet.
    */
    public class func retweet(tweetID: Int, completion: (success: Bool) -> Void) {
        let apiURL = "https://api.twitter.com/1.1/statuses/retweet/\(tweetID).json"
        TwitterJSON.makeRequest(.POST, parameters: nil, apiURL: apiURL) { success, _ in
            dispatch_async(dispatch_get_main_queue(),{
                completion(success: success)
            })
        }
    }

    /**
    Deals with the final request to the API.
    
    :param: SLRequestMethod Will always be either .GET or .POST.
    :param: Dictionary Parameters for the query. 
    :param: Dictionary Parameters for the query.
    :param: String The API url destination.
    :param: Completion Handler for the request containing an error and or JSON.
    */
    private class func makeRequest(requestMethod: SLRequestMethod, parameters: [String : String]!, apiURL: String, completion: ((success: Bool, json: JSON) -> Void)) {
        TwitterJSON.getAccount {(account: ACAccount?) -> Void in
            if let _ = account {
                let postRequest = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: requestMethod, URL: NSURL(string: apiURL), parameters: parameters)
                postRequest.account = account
                postRequest.performRequestWithHandler({ (data: NSData!, urlResponse: NSHTTPURLResponse!, error: NSError!) -> Void in
                    if error == nil {
                        let json = JSON(data: data)
                        completion(success: true, json: json)
                    } else {
                        completion(success: false, json: nil)
                    }
                })
            }
        }
    }
    
    /**
    Get the Twitter account configured in settings.
    
    :param: completion A closure which contains the first account.
    */
    private class func getAccount(completionHandler: (account: ACAccount?) -> Void) {
        let accountStore = ACAccountStore()
        let accountType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
        
        accountStore.requestAccessToAccountsWithType(accountType, options: nil) { (granted: Bool, error: NSError!) -> Void in
            if granted {
            let accounts: [ACAccount] = accountStore.accountsWithAccountType(accountType) as! [ACAccount]
            completionHandler(account: accounts.first!)
            }
        }
    }
}