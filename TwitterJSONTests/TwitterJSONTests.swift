//
//  TwitterJSONTests.swift
//  TwitterJSONTests
//
//  Created by Kyle Goslan on 04/08/2015.
//  Copyright (c) 2015 Kyle Goslan. All rights reserved.
//

import UIKit
import XCTest
import Alamofire
import SwiftyJSON

class TwitterJSONTests: XCTestCase {
    
    func testExample() {
        var tweetJSON = TwitterJSON(apiKey: "xxx", apiSecret: "xxx")
//        XCTAssertEqual(tweetJSON.apiKey, "xxx")
//        XCTAssertEqual(tweetJSON.apiSecret, "xxx")
    }
    
    func testMakeBearerTokenCredentials() {
        var tweetJSON = TwitterJSON(apiKey: "xxx", apiSecret: "xxx")
        tweetJSON.getBearerToken {
            (bearerToken) -> Void in
            XCTAssertNotNil(bearerToken)
        }
    }
    
}