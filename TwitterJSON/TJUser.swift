//
//  TJUser.swift
//  TwitterJSON
//
//  Created by Kyle Goslan on 04/08/2015.
//  Copyright (c) 2015 Kyle Goslan. All rights reserved.
//

import Foundation
import SwiftyJSON

public class TJUser {
    
    public var name: String!
    public var screenName: String!
    public var description: String!
    public var followersCount: Int!
    public var profileImageURL: String!
    public var profileImage: UIImage!
    
    init(userInfo: JSON) {
        
        if let user = userInfo["name"].string {
            self.name = user
        }
        
        if let screenName = userInfo["screen_name"].string {
            self.screenName = screenName
        }
        
        if let description = userInfo["description"].string {
            self.description = description
        }
        
        if let followersCount = userInfo["followers_count"].int {
            self.followersCount = followersCount
        }
        
        if let profileImageURL = userInfo["profile_image_url"].string {
            self.profileImageURL = profileImageURL
        }
        
        if let checkedUrl = NSURL(string: profileImageURL) {
            downloadImage(checkedUrl)
        }
        
    }
    
    func downloadImage(url:NSURL){
        getDataFromUrl(url) { data in
            dispatch_async(dispatch_get_main_queue()) {
                self.profileImage = UIImage(data: data!)
            }
        }
    }
    
    func getDataFromUrl(urL:NSURL, completion: ((data: NSData?) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(urL) { (data, response, error) in
            completion(data: data)
            }.resume()
    }
    
    
}