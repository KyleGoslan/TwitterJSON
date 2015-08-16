//
//  TwitterJSON.swift
//  TwitterJSON
//
//  Created by Kyle Goslan on 04/08/2015.
//  Copyright (c) 2015 Kyle Goslan. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire
import Accounts
import Social

/**
All the real network requests are sent through this object.
*/
public class TwitterJSON {
    
    /**
    Nuber of results to return.
    */
    public static var numberOfResults = 20
    
    /**
    Needed to feedback alerts to the user.
    */
    public static var viewController: UIViewController?

    /**
    Deals with the final request to the API.
    
    :param: SLRequestMethod Will always be either .GET or .POST.
    :param: Dictionary Parameters for the query. 
    :param: Dictionary Parameters for the query.
    :param: String The API url destination.
    :param: Completion Handler for the request containing an error and or JSON.
    */
    public class func makeRequest(requestMethod: SLRequestMethod, parameters: [String : String]!, apiURL: String, completion: ((success: Bool, json: JSON) -> Void)) {
        TwitterJSON.getAccount {(account: ACAccount?) -> Void in
            if let _ = account {
                let postRequest = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: requestMethod, URL: NSURL(string: apiURL), parameters: parameters)
                postRequest.account = account
                postRequest.performRequestWithHandler({ (data: NSData!, urlResponse: NSHTTPURLResponse!, error: NSError!) -> Void in
                    if error == nil {
                        let json = JSON(data: data)
                        completion(success: true, json: json)
                    } else {
                        completion(success: false, json: nil)
                    }
                })
            } else {
                completion(success: false, json: nil)
            }
        }
    }
    
    /**
    Get the Twitter account configured in settings.
    
    :param: completion A closure which contains the first account.
    */
    private class func getAccount(completionHandler: (account: ACAccount?) -> Void) {
        let accountStore = ACAccountStore()
        let accountType = accountStore.accountTypeWithAccountTypeIdentifier(ACAccountTypeIdentifierTwitter)
        
        accountStore.requestAccessToAccountsWithType(accountType, options: nil) { (granted: Bool, error: NSError!) -> Void in
            if granted {
                let accounts: [ACAccount] = accountStore.accountsWithAccountType(accountType) as! [ACAccount]
                if accounts.count == 1 {
                    completionHandler(account: accounts.first!)
                } else {
                    let alertController = UIAlertController(title: "Select an account", message: nil, preferredStyle: .Alert)
                    for account in accounts {
                        let alertAction = UIAlertAction(title: account.username, style: .Default) { (alertAction: UIAlertAction!) -> Void in
                            completionHandler(account: account)
                            println("test")
                        }
                        alertController.addAction(alertAction)
                    }
                    TwitterJSON.viewController?.presentViewController(alertController, animated: true, completion: nil)
                }
            } else {
                let title = "Grant Access To Twitter"
                let message = "You need to give permission for this application to use your Twitter account. Manage in Settings."
                let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
                let action = UIAlertAction(title: "Okay", style: .Default, handler: nil)
                alertController.addAction(action)
                TwitterJSON.viewController?.presentViewController(alertController, animated: true, completion: nil)
            }
        }
    }
    
    /**
    Loads profile images of users.
    
    :param: Optional Array of TJTweet objects.
    :param: Optional Array of TJUser objects.
    :param: Completion Returns the arry of objects passed in with the images loaded.
    */
    internal class func loadImages(tweets: [TJTweet]?, users: [TJUser]?, completion: (tweets: [TJTweet]?, users: [TJUser]?) -> Void) {
        var i = 0
        
        if let tweets = tweets {
            for tweet in tweets {
                Alamofire.request(.GET, tweet.user.profileImageURL).response { (request, response, data, error) in
                    tweet.user.profileImage = UIImage(data: data!, scale:1)
                    i++
                    if i == tweets.count {
                        completion(tweets: tweets, users: nil)
                    }
                }
            }
        }
        
        if let users = users {
            for user in users {
                Alamofire.request(.GET, user.profileImageURL).response { (request, response, data, error) in
                    user.profileImage = UIImage(data: data!, scale:1)
                    i++
                    if i == users.count {
                        completion(tweets: nil, users: users)
                    }
                }
            }
        }
    }
    
}