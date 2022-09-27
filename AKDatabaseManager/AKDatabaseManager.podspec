#
#  Be sure to run `pod spec lint NVNetworking.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|
  spec.name         = "AKDatabaseManager"
  spec.version      = "1.0.0"
  spec.summary      = "A short description of AKDatabaseManager."
  spec.description  = "Network Module"

  spec.homepage     = "http://EXAMPLE/NVNetworking"
  spec.author       = { "Akshay" => "akshay.rathi@navi.com" }
  spec.ios.deployment_target = "15.5"
  spec.source       = { :git => "http://www.github.com/AKDatabaseManager.git", :tag => "#{spec.version}" }
  spec.source_files  = "AKDatabaseManager", "AKDatabaseManager/**/*.{swift,xib}"
  spec.exclude_files = "Classes/Exclude"
end

