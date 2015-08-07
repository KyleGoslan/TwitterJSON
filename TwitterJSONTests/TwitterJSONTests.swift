//
//  TwitterJSONTests.swift
//  TwitterJSONTests
//
//  Created by Kyle Goslan on 04/08/2015.
//  Copyright (c) 2015 Kyle Goslan. All rights reserved.
//

import UIKit
import XCTest
import SwiftyJSON


class TwitterJSONTests: XCTestCase {
    
    var apiKey: String?
    var apiSecret:String?
    var tj: TwitterJSON?
    
    override func setUp() {
        apiKey = "P7JKEueHsWkf8lpqxEN4f1amw"
        apiSecret = "4onJJkjrSEaySwT6pN1reT9RtpnzGSGeZfBszYm4GP0vVbznbD"
        tj = TwitterJSON(apiKey: apiKey!, apiSecret: apiSecret!)
    }
    
    func testAPIKeyValues() {
        XCTAssertEqual(tj!.apiKey, apiKey!)
        XCTAssertEqual(tj!.apiSecret, apiSecret!)
    }
    
    func testGetBearerToken() {
        let expectation = expectationWithDescription("Get Bearer Token")
        let expectedBearerToken = "AAAAAAAAAAAAAAAAAAAAALSQgwAAAAAAfYtOdeJI%2BWbLZyi8fcyfy4OieF4%3DhiTgt5j3plYuaZX7rBJ1zMJzAyWmD0bxFSCjVNa7hKR4hXO0w6"

        tj!.getBearerToken({ (bearerToken, error) -> Void in
            XCTAssertEqual(bearerToken!, expectedBearerToken)
            expectation.fulfill()
        })
        
        waitForExpectationsWithTimeout(5, handler: { error in
            XCTAssertNil(error, "Error")
        })
    }
    
//    func testPerformDataRequestForURL() {
//        let expectation = expectationWithDescription("Got Tweets")
//        let bearerToken = "AAAAAAAAAAAAAAAAAAAAALSQgwAAAAAAfYtOdeJI%2BWbLZyi8fcyfy4OieF4%3DhiTgt5j3plYuaZX7rBJ1zMJzAyWmD0bxFSCjVNa7hKR4hXO0w6"
//        let apiURL = "https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=kylegoslan"
//        tj!.performDataRequestForURL(apiURL, bearerToken: bearerToken, completion: { data in
//            for item in data {
//                let id = item.1["id"].int
//                XCTAssertNotNil(id)
//            }
//            expectation.fulfill()
//        })
//        waitForExpectationsWithTimeout(5, handler: { error in
//            XCTAssertNil(error, "Error")
//        })
//    }

}