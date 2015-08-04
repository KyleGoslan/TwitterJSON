//
//  TJUsers.swift
//  TwitterJSON
//
//  Created by Kyle Goslan on 04/08/2015.
//  Copyright (c) 2015 Kyle Goslan. All rights reserved.
//

import Foundation
import SwiftyJSON

public protocol TJUsersDelegate {
    /**
    Delegate method which contains an array of TJUser objets
    
    :param: Array Collection of TJUser objets.
    */
    func gotUsers(users:[TJUser])
}

public class TJUsers {
    
    private let twitterJSON: TwitterJSON!
    public var delegate: TJUsersDelegate?
    
    public init(apiKey: String, apiSecret: String) {
        self.twitterJSON = TwitterJSON(apiKey: apiKey, apiSecret: apiSecret)
        self.twitterJSON.delegate = self
    }
    
    /**
    Gets the most recent favorited tweets of the user specified in the parameter. Once the results are retrieved
    they are passed to the delegate method as an array of TJTweet objects.
    
    :param: String Screen name of the users whos favorites to retrieve.
    */
    public func getFollowersForUser(screenName: String) {
        twitterJSON.getBearerToken { (bearerToken) -> Void in
            let apiURL = "https://api.twitter.com/1.1/followers/list.json?screen_name=" + screenName
            self.twitterJSON.performDataRequestForURL(apiURL, bearerToken: bearerToken)
        }
    }

}

extension TJUsers: TwitterJSONDelegate {
    
    public func gotdata(data: JSON) {
        var users = [TJUser]()
        println(data)
//        for item in data {
//            let user = TJUser(userInfo: item.1)
//            users.append(user)
//        }
        self.delegate?.gotUsers(users)
    }
    
}