#
# Be sure to run `pod lib lint MobonSDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MobWithAD'
  s.version          = '1.1.3'
  s.summary          = 'A short description of MobWithAD_iOS.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC
  s.homepage         = 'https://github.com/mobon/MobWithAD_iOS'
  s.license          = { :type => 'MIT', :text => 'Copyright 2022 by Enliple'}
  s.summary          = 'MobMixer SDK IOS'
  s.author           = { 'mobon' => 'dhlee@enliple.com' }
  s.source           = { :git => 'https://github.com/mobon/MobWithAD_iOS.git', :tag => s.version.to_s , :submodules => true}
  s.platform = :ios, "12.4"
  s.requires_arc = false
  
  s.vendored_frameworks = 'MobWithADSDKFramework.xcframework'
  
  s.pod_target_xcconfig = {'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64'}
  s.user_target_xcconfig = {'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64'}
  
  
  s.dependency 'AdFitSDK', '~> 3.12.22'
  s.dependency 'AppLovinSDK', '~> 11.6.0'
  
end
