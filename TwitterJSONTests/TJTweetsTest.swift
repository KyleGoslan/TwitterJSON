//
//  TJTweetTest.swift
//  TwitterJSON
//
//  Created by Kyle Goslan on 04/08/2015.
//  Copyright (c) 2015 Kyle Goslan. All rights reserved.
//

import UIKit
import XCTest

class TJTweetsTest: XCTestCase {
    
    var apiKey: String?
    var apiSecret:String?
    var tj: TJTweets?
    var user: String?
    
    override func setUp() {
        user = "KyleGoslan"
        apiKey = "P7JKEueHsWkf8lpqxEN4f1amw"
        apiSecret = "4onJJkjrSEaySwT6pN1reT9RtpnzGSGeZfBszYm4GP0vVbznbD"
        tj = TJTweets(apiKey: apiKey!, apiSecret: apiSecret!)
    }

    func testInit() {
        XCTAssertEqual(tj!.twitterJSON.apiKey, apiKey!)
        XCTAssertEqual(tj!.twitterJSON.apiSecret, apiSecret!)
    }
    
    func testgetTimelineForUser() {
        let expectation = expectationWithDescription("Get User Timeline")
        tj!.getTimelineForUser(user!, completion: { tweets in
            for tweet in tweets {
                XCTAssertNotNil(tweet.text)
                XCTAssertNotNil(tweet.user)
                XCTAssertNotNil(tweet.favoriteCount)
            }
            expectation.fulfill()
        })
        
        waitForExpectationsWithTimeout(5, handler: { error in
            XCTAssertNil(error, "Error")
        })
    }
    
    func testgetFavoritesForUser() {
        let expectation = expectationWithDescription("Get User Favorites")
        tj!.getFavorites(user!, completion: { tweets in
            for tweet in tweets {
                XCTAssertNotNil(tweet.text)
                XCTAssertNotNil(tweet.user)
                XCTAssertNotNil(tweet.favoriteCount)
            }
            expectation.fulfill()
        })
        
        waitForExpectationsWithTimeout(5, handler: { error in
            XCTAssertNil(error, "Error")
        })
    }
    
    func testSearchForTweets() {
        let expectation = expectationWithDescription("Get User Favorites")
        tj!.getFavorites(user!, completion: { tweets in
            for tweet in tweets {
                XCTAssertNotNil(tweet.text)
                XCTAssertNotNil(tweet.user)
                XCTAssertNotNil(tweet.favoriteCount)
            }
            expectation.fulfill()
        })
        
        waitForExpectationsWithTimeout(5, handler: { error in
            XCTAssertNil(error, "Error")
        })
    }
    
    func testGetTweetsForList() {
        let expectation = expectationWithDescription("Get User Favorites")
        tj!.getTweetsForList("great-ios-developers", fromUser: "JoeBlackwell", completion: { tweets in
            for tweet in tweets {
                XCTAssertNotNil(tweet.text)
                XCTAssertNotNil(tweet.user)
                XCTAssertNotNil(tweet.favoriteCount)
            }
            expectation.fulfill()
        })
        
        waitForExpectationsWithTimeout(5, handler: { error in
            XCTAssertNil(error, "Error")
        })
    }
    
    
    
}
