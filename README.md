# TwitterJSON

TwitterJSON makes it very easy to get up and running with Twitter REST api on iOS devices. 
You can start getting responses in just a few lines of code.

## Example

##### Set up your TJTweets object with your api and api secret keys from twitter and set the objects delegate

```swift
	let apiKey = "123456789"
    let apiSecret = "123456789"
    let tjTweets = TJTweets(apiKey: apiKey, apiSecret: apiSecret)
    tjTweets.delegate = self
``` 

##### You can now ask from a response from the api with simple method calls

```swift
	tjTweets.getTimelineForUser("KyleGoslan")
```

##### Conform to the TJTweetDelegate protocol 

```swift
extension ViewController: TJTweetDelegate {
    func gotTweets(tweets: [TJTweet]) {
        for tweet in tweets {
            println(tweet.user)
            println(tweet.text)
        }
    }
}
```

## Installation

### [CocoaPods](http://cocoapods.org)

Add the following line to your Podfile
```bash
pod 'TwitterJSON'
```

Add the following line to your .swift files
```Swift
import TwitterJSON
```