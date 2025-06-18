Pod::Spec.new do |s|
  s.name             = 'MobWithAD'
  s.version          = '1.2.14'
  s.summary          = 'Mobwith AD의 iOS버전 SDK 입니다.'
  s.description      =  <<-DESC
                        'Mobwith AD의 iOS버전 SDK 입니다.'
                        DESC

  s.homepage         = 'https://github.com/mobon/MobWithAD_iOS'
  s.license          = { :type => 'MIT', :text => 'Copyright 2022 by Enliple'}
  s.summary          = 'MobMixer SDK IOS'
  s.author           = { 'mobon' => 'dh.lee@mobwith.co.kr' }
  s.source           = { 
    :git => 'https://github.com/mobon/MobWithAD_iOS.git', 
    :tag => s.version.to_s , 
    :submodules => true
  }

  s.platform = :ios, "13.0"
  s.requires_arc = false
  
  
  s.vendored_frameworks = 'MobWithADSDKFramework.xcframework', 'CouOffsiteAds.xcframework'
  s.resource = 'MobWithADSDKBundle.bundle'
  
  s.pod_target_xcconfig = {'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64'}
  
  
  s.dependency 'AdFitSDK', '3.14.5'
  s.dependency 'UnityAds', '4.14.1'
  s.dependency 'Ads-Global', '7.1.1.1'
  s.dependency 'IronSourceSDK','8.7.0.0'
  
end
