//
//  TJUsers.swift
//  TwitterJSON
//
//  Created by Kyle Goslan on 04/08/2015.
//  Copyright (c) 2015 Kyle Goslan. All rights reserved.
//

import Foundation
import SwiftyJSON

public class TJUsers {
    
    public let twitterJSON: TwitterJSON!
    
    public init(apiKey: String, apiSecret: String) {
        self.twitterJSON = TwitterJSON(apiKey: apiKey, apiSecret: apiSecret)
    }
    
    /**
    Gets the most recent followers of the user specified in teh parameter. Once the reults are retrieved they are 
    passed to the delegate method as an array of TJUser objects.
    
    :param: String Screen name of the users whos followers to retrieve.
    */
    public func getFollowersForUser(screenName: String, completion: (users: [TJUser]) -> Void) {
        twitterJSON.getBearerToken { (bearerToken) -> Void in
            let apiURL = "https://api.twitter.com/1.1/followers/list.json?screen_name=" + screenName
            self.twitterJSON.performDataRequestForURL(apiURL, bearerToken: bearerToken, completion: { data in
                var users = [TJUser]()
                for item in data["users"] {
                    let user = TJUser(userInfo: item.1)
                    users.append(user)
                }
                completion(users: users)
            })
        }
    }

}