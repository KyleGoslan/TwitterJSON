//
//  TwitterJSON.swift
//  TwitterJSON
//
//  Created by Kyle Goslan on 04/08/2015.
//  Copyright (c) 2015 Kyle Goslan. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

public protocol TwitterJSONDelegate {
    func gotdata(data: JSON)
}

public class TwitterJSON {
    
    public let apiKey: String!
    public let apiSecret: String!
    
    public var delegate: TwitterJSONDelegate?
    
    public init(apiKey: String, apiSecret: String) {
        self.apiKey = apiKey
        self.apiSecret = apiSecret
    }
    
    public func getBearerToken(completion: (bearerToken: String) -> Void) {
        let bearerTokenCredentials = apiKey! + ":" + apiSecret!
        let bearerTokenCredentialsData = (bearerTokenCredentials as NSString).dataUsingEncoding(NSUTF8StringEncoding)
        let base64String = bearerTokenCredentialsData!.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
        
        var loginRequest = NSMutableURLRequest(URL: NSURL(string:"https://api.twitter.com/oauth2/token?grant_type=client_credentials")!)
        loginRequest.HTTPMethod = "POST"
        loginRequest.addValue("Basic \(base64String)", forHTTPHeaderField: "Authorization")
        loginRequest.addValue("text/plain", forHTTPHeaderField: "content-type")
        
        Alamofire.request(loginRequest)
            .responseJSON { request, response, json, error in
                if error == nil {
                    var json = JSON(json!)
                    completion(bearerToken: json["access_token"].stringValue)
                }
        }
    }
    
    public func performDataRequestForURL(apiURL: String, bearerToken: String) {
        var dataRequest = NSMutableURLRequest(URL: NSURL(string:apiURL)!)
        dataRequest.HTTPMethod = "GET"
        dataRequest.addValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
        
        Alamofire.request(dataRequest)
            .responseJSON { request, response, json, error in
                if error == nil {
                    var json = JSON(json!)
                    self.delegate?.gotdata(json)
                }
        }
    }
    
    public func getTimeline(screenName: String) {
        getBearerToken { (bearerToken) -> Void in
            let apiURL = "https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=" + screenName
            self.performDataRequestForURL(apiURL, bearerToken: bearerToken)
        }
    }
    
}
