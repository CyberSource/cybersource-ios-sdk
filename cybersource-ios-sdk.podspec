#
# Be sure to run `pod lib lint cybersource-ios-sdk' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "cybersource-ios-sdk"
  s.version          = "1.0.3"
  s.summary          = "iOS SDK for CyberSource"
  s.description      = "The CyberSource InApp SDK enables developers to simply and securely incorporate mobile payments into their iOS applications."
  s.homepage         = "https://github.com/CyberSource/cybersource-ios-sdk"
  s.license          = 'https://github.com/CyberSource/cybersource-ios-sdk/blob/master/LICENSE'
  s.author           = { "CyberSource" => "developer@cybersource.com" }
  s.source           = { :git => "https://github.com/CyberSource/cybersource-ios-sdk.git" , :tag => s.version.to_s}

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.vendored_framework = 'Frameworks/InAppSDK.framework'

end
