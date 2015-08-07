# TwitterJSON

TwitterJSON makes it very easy to get up and running with the Twitter REST api on iOS devices. 
You can start getting responses in just a few lines of code.

## Example

Set up your TJTweets object with your api and api secret keys from, for example:

```swift
	let apiKey = "123456789"
    let apiSecret = "123456789"
    let tjTweets = TJTweets(apiKey: apiKey, apiSecret: apiSecret)
``` 

You can now ask for a response with simple method calls:

```swift
	tjTweets.getFavorites("KyleGoslan", completion: { tweets, error in
    
    })
```

Responses are handled in the methods completion handler. In the example above you get back an array of TJTweet objects (objects that hold information about a tweet). You can do whatever you want with this array, for example: 

```swift
	tjTweets.getFavorites("KyleGoslan", completion: { tweets, error in
        for tweet in tweets {
            println(tweet.user.name)
            println(tweet.text)
        }
    })
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
## Getting Twitter API Keys

Since Twitter deprected v1.0 of their api **all** api calls need some form of authentication. To get 
started with the TwitterJSON Framework you need to set up a Twitter app here:

[https://apps.twitter.com](https://apps.twitter.com)

Complete the form and under the 'Keys and Access Tokens' tab you'll find the two keys you need to
get started with the TwitterJSON library. 

* Consumer Key (API Key)
* Consumer Secret (API Secret)

## Getting Tweets

To get tweets you'll instanciate a new `TJTweets` object, passing in the two api keys documented above:

```swift
    var tjTweets = TJTweets(apiKey: "xxx", apiSecret: "xxx")
```

Call the helper method which will return an array of `TJTweet` objects, for example:

```swift 
    tjTweets.getTimelineForUser("KyleGoslan" , completion: { tweets, error in
        for tweet in tweets {
            println(tweet.user.name)
            println(tweet.text)
        }
    })
```

**Note:** All tweets also contain a `TJUser` object which is 
the infomation about the user who posted the tweet. 

## Getting Users

Getting users is very similier to getting tweets except you create a `TJUsers` object rather than a `TJTweets` object 

```swift
    var tjUsers = TJUsers(apiKey: "xxx", apiSecret: "xxx")
```

Call the helper method to return the users you want, for example:

```swift 
    tjTweets.getFollowersForUser("KyleGoslan" , completion: { users, error in
        for user in users {
            println(user.name)
            println(user.description)
        }
    })
```

## Error Handling

Every method that you call to retrive data from Twitter has an optional `NSError` object with it. If the API request was successful then this will be `nil`. 

The most basic error handling can be done like this: 

```swift
    tjUsers.getFollowersForUser("kylegoslan", completion: { users, error in
        if error == nil {
            //Do whater you want with users array. 
        } else {
            //Handle the error.
        }
    })
```

You coud simply alert the user that something went wrong, try again, or do nothing. However, TwitterJSON will try to give you a cause for the error, allowing you to take different action accordingly.

### Specific Error Handling

Typically there are three scenarios that can cause an error:

- No data connection.
- Invalid api requests.
- Wrong api and api secret keys. 

`NSError` objects typically have 'description' and 'code' properties. You can get more information about the error by printing them out: 

```swift 
    println(error.code)
    println(error.description)
```

Not having a data connection is the only one that iOS really knows about. The other two causes come from the Twitters response to the API request. TwitterJSON will try and populate the error object with the appropriate informatiom. 

- Error code: -1009
    - No data connection.
- Error code: 34
    - Bad api request. For example the user could not be found. 
- Error code: 99
    - Bad authentication. Check your API and API secret keys. 

Example showing a simple alert:
```swift
    if error.code == 34 {
        let myAlert = UIAlertView(title: "Sorry", message: "Could not find user.", delegate: nil, cancelButtonTitle: "Dismiss")
        myAlert.show()
    }
```

## Requirements

- iOS 8.0+
- Xcode 6.4

## A Little More Info

There are two types of objets you'll mainly instantiate, `TJTweets` and `TJUsers`.

Simply put a `TJTweets` method calls will return and array of `TJTweet` objects, where as a `TJUsers` method calls will 
return and array of `TJUser` objects. The difference being that if you're asking for an collection of tweets, all tweets inheritably must have a user, but if you were searching for a collection of users, then you wouldn't be expecting back any tweets.  
