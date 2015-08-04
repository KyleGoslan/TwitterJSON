Pod::Spec.new do |s|

s.platform = :ios
s.ios.deployment_target = '8.0'
s.name = "TwitterJSON"
s.summary = "Simple framework for using the Twitter REST API's."
s.requires_arc = true

s.version = "0.0.2"
s.license = { :type => "MIT", :file => "LICENSE" }
s.author = { "Kyle Goslan" => "kylegoslan@me.com" }
s.homepage = "https://github.com/KyleGoslan/TwitterJSON"
s.source = { :git => "https://github.com/KyleGoslan/TwitterJSON.git", :tag => "#{s.version}"}

s.frameworks = "Foundation", "UIKit"
s.dependency 'Alamofire', '~> 1.3'
s.dependency 'SwiftyJSON', '~> 2.2.1'
s.source_files = "TwitterJSON"

end