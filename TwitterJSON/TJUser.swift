//
//  TJUser.swift
//  TwitterJSON
//
//  Created by Kyle Goslan on 04/08/2015.
//  Copyright (c) 2015 Kyle Goslan. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

/**
A single user object.

Contains information related to a single user.
*/
public class TJUser {
    
    /**
    The full name of the user
    */
    public var name: String!
    
    /**
    The screen name of the user
    */
    public var screenName: String!
    
    /**
    User bio/description
    */
    public var description: String!
    
    /**
    How many followers the user has
    */
    public var followersCount: Int!
    
    /**
    Use this to check if a user has a profile image. Defaults to false
    */
    public var hasProfileImage = false
    
    /**
    If the user has a profile image this will hold the url to the image
    */
    public var profileImageURL: String!
    
    /**
    If the user has a profile image this will load the image into a UIImage
    */
    public var profileImage: UIImage!

    /**
    Initilize with a json object.

    The init method parses the json and sets the objets properties.
    */
    init(userInfo: JSON) {
        
        if let user = userInfo["name"].string {
            self.name = user
        } else {
            self.name = nil
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

    }
    
    public func loadImage(imageView: UIImageView)  {
        Alamofire.request(.GET, profileImageURL).response { (request, response, data, error) in
            self.profileImage = UIImage(data: data!, scale:1)
            imageView.image = self.profileImage
        }
    }
    
    
}