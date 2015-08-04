# TwitterJSON

TwitterJSON makes it very easy to get up and running with the Twitter REST api on iOS devices. 
You can start getting responses in just a few lines of code.

## Example

##### Set up your TJTweets object with your api and api secret keys from twitter and set the objects delegate

```swift
	let apiKey = "123456789"
    let apiSecret = "123456789"
    let tjTweets = TJTweets(apiKey: apiKey, apiSecret: apiSecret)
    tjTweets.delegate = self
``` 

##### You can now ask for a response with simple method calls

```swift
	tjTweets.getTimelineForUser("KyleGoslan")
```

##### Conform to the TJTweetDelegate protocol 

```swift
extension ViewController: TJTweetDelegate {
    func gotTweets(tweets: [TJTweet]) {
        for tweet in tweets {
            println(tweet.text)
            println(tweet.user.screenName)
        }
    }
}
```

The result from the above example would create a log message containing the tweet and the users screen 
name who published the tweet. By default the method call will return the 20 most recent tweets starting 
with the most recent tweet.


## Installation

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. CocoaPods 0.36 adds supports 
for Swift and embedded frameworks. You can install it with the following command:

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

*Consumer Key (API Key)
*Consumer Secret (API Secret)

## Getting Tweets

To get tweets you'll instanciate a new TJTweets object, passing in the two api keys documented above.

```swift
    var tjTweets = TJTweets(apiKey: "xxx", apiSecret: "xxx")
```

Set the delegate of the new TJTweets object.

```swift 
    tjTweets.delegate = self 
```

Set the delegate in the class (probably a view controller) that you're working in eg.

```swift
    class ViewController: UIViewController, TJTweetDelegate {
```

Call the helper method to return the tweets you want, for example

```swift 
    tjTweets.getTimelineForUser("KyleGoslan")
```

Finally, implement the delegate method. This method receives an array (20 by default) of `TJTweet` objects. These each represent a tweet. 

```swift
    func gotTweets(tweets: [TJTweet]) {
        
    }
```

**Note:** All tweets also contain a `TJUser` object which is 
the infomation about the user who posted the tweet. 

## Requirements

- iOS 8.0+
- Xcode 6.4

## A Little More Info

There are two types of objets you'll mainly instantiate, `TJTweets` and `TJUsers`.

Simply put a `TJTweets` method calls will return and array of `TJTweet` objects, where as a `TJUsers` method calls will 
return and array of `TJUser` objects. The difference being that if you're asking for an collection of tweets, all tweets inheritably 
must have a user, but if you were searching for a collection of users, then you wouldn't be expecting back any tweets.  
