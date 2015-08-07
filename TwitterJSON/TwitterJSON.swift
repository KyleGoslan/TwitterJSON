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

/**
All the real network requests are sent through this object.

Uses the Alamofire library.
*/
public class TwitterJSON {
    
    /**
    Api key from Twitter.
    */
    public let apiKey: String!
    
    /**
    Api secret key from Twitter.
    */
    public let apiSecret: String!
    
    /**
    Initialize with api and api secret keys from Twitter.
    */
    public init(apiKey: String, apiSecret: String) {
        self.apiKey = apiKey
        self.apiSecret = apiSecret
    }

    /**
    Combines and encrypts the api key and the secret key and exchanges them for 
    a bearer token via a network request.
    
    :param: completion The code to be executed once the request has finished.
    */
    public func getBearerToken(completion: (bearerToken: String?, error: NSError?) -> Void) {
        let bearerTokenCredentials = apiKey! + ":" + apiSecret!
        let bearerTokenCredentialsData = (bearerTokenCredentials as NSString).dataUsingEncoding(NSUTF8StringEncoding)
        let base64String = bearerTokenCredentialsData!.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
        var loginRequest = NSMutableURLRequest(URL: NSURL(string:"https://api.twitter.com/oauth2/token?grant_type=client_credentials")!)
        loginRequest.HTTPMethod = "POST"
        loginRequest.addValue("Basic \(base64String)", forHTTPHeaderField: "Authorization")
        loginRequest.addValue("text/plain", forHTTPHeaderField: "content-type")
        
        Alamofire.request(loginRequest).responseJSON { request, response, json, error in
            if error == nil {
                var json = JSON(json!)
                if let accessToken = json["access_token"].string {
                    completion(bearerToken:accessToken, error: nil)
                } else {
                    var dict = [String: String]()
                    dict["Twitter Error"] = json["errors"][0]["message"].stringValue + " - " + json["errors"][0]["label"].stringValue
                    let error = NSError(domain: "", code: json["errors"][0]["code"].intValue, userInfo: dict)
                    completion(bearerToken:nil, error: error)
                }
            } else {
                completion(bearerToken: nil, error: error)
            }
        }
    }
    
    /**
    Performs the network request to retrieve the json data from twitter.
    
    :param: String The complete REST api url
    :param: String A valid bearer token
    :param: completion The code to be executed once the request has finished.
    */
    public func performDataRequestForURL(apiURL: String, completion: (data: JSON?, error: NSError?) -> Void) {
        getBearerToken { (bearerToken, error) -> Void in
            if error == nil {
                if let bearerToken = bearerToken {
                    var dataRequest = NSMutableURLRequest(URL: NSURL(string:apiURL)!)
                    dataRequest.HTTPMethod = "GET"
                    dataRequest.addValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
                    Alamofire.request(dataRequest).responseJSON { request, response, json, error in
                        if error == nil {
                            var json = JSON(json!)
                            if let error = json["errors"].array {
                                var dict = [String: String]()
                                dict["Twitter Error"] = json["errors"][0]["message"].stringValue + " - " + json["errors"][0]["label"].stringValue
                                let error = NSError(domain: "", code: json["errors"][0]["code"].intValue, userInfo: dict)
                                completion(data:nil, error: error)
                            } else {
                                completion(data: json, error: error)
                            }
                        } else {
                            completion(data: nil, error: nil)
                        }
                    }
                }
            } else {
                completion(data: nil, error: error)
            }
        }
    }

}
