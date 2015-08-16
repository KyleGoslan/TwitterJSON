//
//  GetUsers.swift
//  TwitterJSON
//
//  Created by Kyle Goslan on 14/08/2015.
//  Copyright (c) 2015 Kyle Goslan. All rights reserved.
//

import Foundation

/**
Methods that deal with returning an array of users are in this file.
*/
extension TwitterJSON {
    
    /**
    Get the followers for the given user
    
    :param: String Username of the user whos followers to retrive.
    :param: Completion Containts an array of TJTweet objects.
    */
    public class func getFollowersForUser(userName: String, completion: (users: [TJUser]) -> Void) {
        let apiURL = "https://api.twitter.com/1.1/followers/list.json"
        let parameters = [
            "screen_name": userName,
            "count": "\(TwitterJSON.numberOfResults)"
        ]
        TwitterJSON.makeRequest(.GET, parameters: parameters, apiURL: apiURL) { success, json in
            var users = [TJUser]()
            for item in json["users"] {
                let user = TJUser(userInfo: item.1)
                users.append(user)
            }
            TwitterJSON.loadImages(nil, users: users, completion: { (tweets, users) -> Void in
                dispatch_async(dispatch_get_main_queue(),{
                    completion(users: users!)
                })
            })
        }
    }
    
    /**
    Get the people the given user is following
    
    :param: String Username of the user whos followers you want to retrieve.
    :param: Completion Containts an array of TJTweet objects.
    */
    public class func getFollowingForUser(userName: String, completion: (users: [TJUser]) -> Void) {
        let apiURL = "https://api.twitter.com/1.1/friends/list.json"
        let parameters = [
            "screen_name": userName,
            "count": "\(TwitterJSON.numberOfResults)"
        ]
        TwitterJSON.makeRequest(.GET, parameters: parameters, apiURL: apiURL) { success, json in
            var users = [TJUser]()
            for item in json["users"] {
                let user = TJUser(userInfo: item.1)
                users.append(user)
            }
            TwitterJSON.loadImages(nil, users: users, completion: { (tweets, users) -> Void in
                dispatch_async(dispatch_get_main_queue(),{
                    completion(users: users!)
                })
            })
        }
    }
    
}
