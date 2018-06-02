source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'
inhibit_all_warnings!
use_frameworks!
install! 'cocoapods', :deterministic_uuids => false

workspace 'BBCap.xcworkspace'

target 'BBCap' do
    project 'BBCap'

    # Architect
    pod 'MVVM-Swift', '1.1.0' # MVVM Architect for iOS Application.
    # UI
    # pod 'SVProgressHUD', '2.2.5' # A clean and lightweight progress HUD for your iOS and tvOS app.
    # Data
    pod 'LGSideMenuController'
    pod 'Font-Awesome-Swift', '~> 1.7.2'

    pod 'ObjectMapper', '3.1.0' # Simple JSON Object mapping written in Swift.    # Network
    pod 'Alamofire', '4.6.0' # Elegant HTTP Networking in Swift.
    pod 'AlamofireNetworkActivityIndicator', '2.2.0' # Controls the visibility of the network activity indicator on iOS using Alamofire.

    # Utils
    pod 'SwiftLint', '0.25.0' # A tool to enforce Swift style and conventions.
    pod 'SwiftUtils', '4.0.1' # Swift shorthand.
    pod 'SwifterSwift', '4.2.0'
    pod 'Charts', '3.1.0'
    pod 'SwiftDate', '4.5.0'
    pod 'IQKeyboardManagerSwift'

target 'BBCapTests' do
    inherit! :complete
    pod 'Quick', '1.3.0'
    pod 'Nimble', '7.1.1'
    pod 'OHHTTPStubs', '6.1.0'
    pod 'OHHTTPStubs/Swift'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            if config.name == 'Release'
                config.build_settings['SWIFT_OPTIMIZATION_LEVEL'] = '-Owholemodule'
            end
            config.build_settings['SWIFT_VERSION'] = '4.0'
        end
        end
    end
end
