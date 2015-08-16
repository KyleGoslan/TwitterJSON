# TwitterJSON

TwitterJSON makes it very easy to get up and running with the Twitter REST api on iOS devices. 
You can start getting responses in just a few lines of code. It uses the account from the persons device to 
authorize requests. 

## Example

You can start getting results from Twitter with just one method call. For example, to get the main feed of the user: 

```swift
	TwitterJSON.getHomeFeed { (tweets) -> Void in
            
    }
``` 

All methods are class methods of the `TWitterJSON` class, so no need to initilize any objects. In the example above the
completion handler contains an array of TJTweet objects. Each of which represent a tweet. You can now do what you want
with this array of tweets, for example: 

```swift
    TwitterJSON.getHomeFeed { (tweets) -> Void in
        for tweet in tweets {
            println(tweet.user.name)
            println(tweet.text)
        }
    }
```

Thats it!

## Installation

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. CocoaPods 0.36 adds   supports for Swift and embedded frameworks. You can install it with the following command:

```bash
    $ gem install cocoapods
```

To integrate TwitterJSON into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
    source 'https://github.com/CocoaPods/Specs.git'
    platform :ios, '8.0'
    use_frameworks!

    pod 'TwitterJSON'
```

Then, run the following command:

```bash
    $ pod install
```
## Number of Results

By default all requests that return an array of either tweets or users will return 20 results. This is defined as a static class variable, meaning that when you set it it will remain at that until it is later changed. To change the number of results:

```swift 
    TwitterJSON.numberOfResults = 5 
```

**Note:** Twitters REST API requests have limits.

## Getting Tweets

The following methods get tweets, and will return an array of TJTweet objects.

```Swift
    TwitterJSON.getHomeFeed { (tweets) -> Void in
        //Returns tweets from the users home feed. 
    }
```

```Swift
    TwitterJSON.searchForTweets("Apple", completion: { (tweets) -> Void in
        //Returns tweets containing the given search query.
    })
```

**Note:** All tweets also contain a `TJUser` object which is 
the infomation about the user who posted the tweet. 

## Getting Users

The following methods get users, and will return an array of TJUser objects.

```swift
    TwitterJSON.getFollowersForUser("KyleGoslan", completion: { (users) -> Void in
        //Returns a list of followers following the specified user.
    })
```

```swift
    TwitterJSON.getFollowingForUser("KyleGoslan", completion: { (users) -> Void in
        //Returns a list of people the specified user is following.
    })
```

## Post Requests

The following methods will post data to Twitter and return a bool value to represent success. 

```swift 
    TwitterJSON.postTweet("Hello World", completion: { (success) -> Void in
        //Will post the given string to twitter.
    })
```

```swift
    TwitterJSON.retweet(123456789, completion: { (success) -> Void in
        //Will retweet the tweet with the given ID.
    })
```

```swift
    TwitterJSON.favoriteTweet(123456789, completion: { (success) -> Void in
        //Will favorite the tweet with the given ID.
    })
```

## Requirements

- iOS 8.0+
- Xcode 6.4 
