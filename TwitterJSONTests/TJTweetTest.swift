//
//  TJTweetTest.swift
//  TwitterJSON
//
//  Created by Kyle Goslan on 04/08/2015.
//  Copyright (c) 2015 Kyle Goslan. All rights reserved.
//

import UIKit
import XCTest

class TJTweetTest: XCTestCase {

    func testCanInit() {
        var tweetJSON = TJTweet(apiKey: "xxx", apiSecret: "xxx")
        XCTAssertEqual(tweetJSON.twitterJSON.apiKey, "xxx")
        XCTAssertEqual(tweetJSON.twitterJSON.apiKey, "xxx")
    }
    
}
