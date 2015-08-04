//
//  TJTweet.swift
//  TwitterJSON
//
//  Created by Kyle Goslan on 04/08/2015.
//  Copyright (c) 2015 Kyle Goslan. All rights reserved.
//

import Foundation
import SwiftyJSON

public class TJTweet {
    
    public let twitterJSON: TwitterJSON!
    
    public init(apiKey: String, apiSecret: String) {
        self.twitterJSON = TwitterJSON(apiKey: apiKey, apiSecret: apiSecret)
        self.twitterJSON.delegate = self
    }

}

extension TJTweet: TwitterJSONDelegate {
    public func gotdata(data: JSON) {
        
    }
}