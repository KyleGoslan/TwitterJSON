# Change Log
All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning](http://semver.org/).

## Unreleased
#### Changed
- Removed the TwitterJSON protocol methods so this class no longer has a delegate. Date is now returned in a completion handler.
    - Changed by [Kyle Goslan](https://github.com/KyleGoslan).
- TJTweets & TJUsers objects no longer have delegate methods. Uses completion handlers instead, which makes the library even easier to implement and use.
    - Changed by [Kyle Goslan](https://github.com/KyleGoslan).
    
#### Added
- Completion handlers rather than delegate methods.
    - Added by [Kyle Goslan](https://github.com/KyleGoslan).
- Added 100% test coverage for the TwitterJSON class.
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