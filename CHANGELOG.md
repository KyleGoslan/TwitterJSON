# Change Log
All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning](http://semver.org/).

## Unreleased
#### Changed
#### Added

## [0.2.3](https://github.com/KyleGoslan/TwitterJSON/releases/tag/0.2.3)
Released on 2015-12-09.

#### Added
- Expanded the TJTweet class to incude more properties.
    * retweet count
    * hashtags
    * urls
    * user mentions
    - Added by [Kyle Goslan](https://github.com/KyleGoslan).

## [0.2.2](https://github.com/KyleGoslan/TwitterJSON/releases/tag/0.2.2)
Released on 2015-08-09.

#### Added
- All TJUser objects now have the users profile image autmatically downloaded and ready to use. 
     - Added by [Kyle Goslan](https://github.com/KyleGoslan).
- You can now print your twitter apps rate limit to check your useage. 
     - Added by [Kyle Goslan](https://github.com/KyleGoslan).
- Number of properties to TJUser objects.
     - Added by [Kyle Goslan](https://github.com/KyleGoslan).


## [0.2.1](https://github.com/KyleGoslan/TwitterJSON/releases/tag/0.2.1)
Released on 2015-08-07.

#### Changed
- Fixed bug in searchForTweets method that resulted in no errors being returned when there should be.
    - Changed by [Kyle Goslan](https://github.com/KyleGoslan).

## [0.2.0](https://github.com/KyleGoslan/TwitterJSON/releases/tag/0.2.0)
Released on 2015-08-07.

#### Added
- Added error handling for all API method calls. See documentation. 
     - Added by [Kyle Goslan](https://github.com/KyleGoslan).

## [0.1.5](https://github.com/KyleGoslan/TwitterJSON/releases/tag/0.1.5)
Released on 2015-08-05.

#### Added
- Added TJUsers `getFollowingForUser(screenName: String, completion: (users: [TJUser]) -> Void) {..}` method.
    - Added by [Kyle Goslan](https://github.com/KyleGoslan).
- Added TJUsers `getFollowingForUser(screenName: String, completion: (users: [TJUser]) -> Void) {..}` method.
    - Added by [Kyle Goslan](https://github.com/KyleGoslan).
- Added TJTweets `func getTweetsForList(listSlug: String, fromUser user: String, completion: (tweets: [TJTweet]) -> Void) {...}` method.
    - Added by [Kyle Goslan](https://github.com/KyleGoslan).
- Added a number of tests.
    - Added by [Kyle Goslan](https://github.com/KyleGoslan).

## [0.1.4](https://github.com/KyleGoslan/TwitterJSON/releases/tag/0.1.4)
Released on 2015-08-05.

#### Changed
- Removed the TwitterJSON protocol methods so this class no longer has a delegate. Date is now returned in a completion handler.
    - Changed by [Kyle Goslan](https://github.com/KyleGoslan).
- TJTweets & TJUsers objects no longer have delegate methods. Uses completion handlers instead, which makes the library even easier to implement and use.
    - Changed by [Kyle Goslan](https://github.com/KyleGoslan).
    
#### Added
- Completion handlers rather than delegate methods.
    - Added by [Kyle Goslan](https://github.com/KyleGoslan).
- Added tests.
    - Added by [Kyle Goslan](https://github.com/KyleGoslan).

## [0.1.3](https://github.com/KyleGoslan/TwitterJSON/releases/tag/0.1.3)
Released on 2015-08-04.

#### Added
- Added TJUsers class for retrieving list of users.
  - Added by [Kyle Goslan](https://github.com/KyleGoslan).


## [0.1.2](https://github.com/KyleGoslan/TwitterJSON/releases/tag/0.1.2)
Released on 2015-08-04.

#### Added
- Improved documentation in README.
  - Added by [Kyle Goslan](https://github.com/KyleGoslan).
- Added inline documentation for help on method calls inside Xcode.
  - Added by [Kyle Goslan](https://github.com/KyleGoslan).
  
## [0.1.1](https://github.com/KyleGoslan/TwitterJSON/releases/tag/0.1.1)
Released on 2015-08-04.

#### Added
- Core functionality.
  - Added by [Kyle Goslan](https://github.com/KyleGoslan).

## [0.0.1](https://github.com/KyleGoslan/TwitterJSON/releases/tag/0.0.1)
Released on 2015-08-03.

#### Added
- Initial release of TwitterJSON.
  - Added by [Kyle Goslan](https://github.com/KyleGoslan).