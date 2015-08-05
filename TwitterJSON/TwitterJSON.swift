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

public class TwitterJSON {
    
    public let apiKey: String!
    public let apiSecret: String!
    
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
    
    public func performDataRequestForURL(apiURL: String, bearerToken: String, completion: (data: JSON) -> Void) {
        var dataRequest = NSMutableURLRequest(URL: NSURL(string:apiURL)!)
        dataRequest.HTTPMethod = "GET"
        dataRequest.addValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
        
        Alamofire.request(dataRequest)
            .responseJSON { request, response, json, error in
                if error == nil {
                    var json = JSON(json!)
                    completion(data: json)
                }
        }
    }
    
}
