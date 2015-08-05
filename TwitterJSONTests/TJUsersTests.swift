//
//  TJUsersTests.swift
//  TwitterJSON
//
//  Created by Kyle Goslan on 05/08/2015.
//  Copyright (c) 2015 Kyle Goslan. All rights reserved.
//

import UIKit
import XCTest

class TJUsersTests: XCTestCase {

    var apiKey: String?
    var apiSecret:String?
    var tj: TJUsers?
    var user: String?
    
    override func setUp() {
        user = "KyleGoslan"
        apiKey = "P7JKEueHsWkf8lpqxEN4f1amw"
        apiSecret = "4onJJkjrSEaySwT6pN1reT9RtpnzGSGeZfBszYm4GP0vVbznbD"
        tj = TJUsers(apiKey: apiKey!, apiSecret: apiSecret!)
    }
    
    func testInit() {
        XCTAssertEqual(tj!.twitterJSON.apiKey, apiKey!)
        XCTAssertEqual(tj!.twitterJSON.apiSecret, apiSecret!)
    }
    
    func testGetFollowersForUser() {
        let expectation = expectationWithDescription("Get Users")
        tj?.getFollowersForUser(user!, completion: { users in
            for user in users {
                XCTAssertNotNil(user.name)
            }
            expectation.fulfill()
        })
        waitForExpectationsWithTimeout(5, handler: { error in
            XCTAssertNil(error, "Error")
        })
    }

}
