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
    
    override func setUp() {

    }
    
    func testGetHomeFeed() {
        let expectation = expectationWithDescription("Test Get Home Feed")
        
        TwitterJSON.getHomeFeed { (tweets) -> Void in
            XCTAssertEqual(tweets.count, 20)
            expectation.fulfill()
        }
        
        waitForExpectationsWithTimeout(5, handler: { error in
            XCTAssertNil(error, "Error")
        })
    }
    
    func testRetweet() {
        let expectation = expectationWithDescription("Test Retweet")
        
        TwitterJSON.retweet(632158353607802880, completion: { (success) -> Void in
            XCTAssertTrue(success)
            expectation.fulfill()
        })
        
        waitForExpectationsWithTimeout(5, handler: { error in
            XCTAssertNil(error, "Error")
        })
    }
    
    func testPostTweet() {
        let expectation = expectationWithDescription("Test Post Tweet")
        
        TwitterJSON.postTweet("Posted from running test in my project...", completion: { (success) -> Void in
            XCTAssertTrue(success)
            expectation.fulfill()
        })
        
        waitForExpectationsWithTimeout(5, handler: { error in
            XCTAssertNil(error, "Error")
        })
    }
    
    func testSearchForTweets() {
        let expectation = expectationWithDescription("Test Search Tweets")
        
        TwitterJSON.searchForTweets("Apple", completion: { (tweets) -> Void in
            XCTAssertEqual(tweets.count, 15)
            expectation.fulfill()
        })
        
        waitForExpectationsWithTimeout(5, handler: { error in
            XCTAssertNil(error, "Error")
        })
    }
    
    

}