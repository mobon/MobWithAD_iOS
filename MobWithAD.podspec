Pod::Spec.new do |s|
  s.name             = 'MobWithAD'
  s.version          = '1.2.36'
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

  s.platform = :ios, "15.6"
  s.requires_arc = false
  
  
  s.vendored_frameworks = 'MobWithADSDKFramework.xcframework', 'CouOffsiteAds.xcframework', 'CaulySDK.xcframework'
  s.resource = 'MobWithADSDKBundle.bundle'
  
  s.pod_target_xcconfig = {'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64'}
  
  
  s.dependency 'AdFitSDK', '3.14.5'
  s.dependency 'UnityAds', '4.14.1'
  s.dependency 'Ads-Global', '7.2.0.6'
  s.dependency 'IronSourceSDK','9.2.0.0'
  s.dependency 'Fyber_Marketplace_SDK', '8.3.8'
  s.dependency 'BidmadSDK/core', '6.13.3'
  s.dependency 'OpenBiddingHelper', '6.13.2'
  s.dependency 'BidmadAdmixerAdapter', '2.0.2.12.2'
  s.dependency 'BidmadAppLovinAdapter', '13.3.1.12.1'
  s.dependency 'BidmadGoogleAdManagerAdapter', '12.6.0.12.1'
  s.dependency 'BidmadGoogleAdMobAdapter', '12.6.0.12.1'
  s.dependency 'BidmadORTBAdapter', '1.0.0.12.1'
  s.dependency 'BidmadTaboolaAdapter', '3.8.33.12.1'
  s.dependency 'BidmadTeadsAdapter', '5.2.0.12.1'
  s.dependency 'BidmadVungleAdapter', '7.5.1.12.1'
  s.dependency 'InMobiSDK', '10.8.6'
  s.dependency 'Google-Mobile-Ads-SDK', '12.6.0'
  
end
