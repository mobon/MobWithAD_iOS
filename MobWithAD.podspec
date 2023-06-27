Pod::Spec.new do |s|
  s.name             = 'MobWithAD'
  s.version          = '1.2.1'
  s.summary          = 'Mobwith AD의 iOS버전 SDK 입니다.'
  s.description      =  <<-DESC
                        'Mobwith AD의 iOS버전 SDK 입니다.'
                        DESC

  s.homepage         = 'https://github.com/mobon/MobWithAD_iOS'
  s.license          = { :type => 'MIT', :text => 'Copyright 2022 by Enliple'}
  s.summary          = 'MobMixer SDK IOS'
  s.author           = { 'mobon' => 'dhlee@enliple.com' }
  s.source           = { 
    :git => 'https://github.com/mobon/MobWithAD_iOS.git', 
    :tag => s.version.to_s , 
    :submodules => true
  }

  s.platform = :ios, "13.0"
  s.requires_arc = false
  
  
  s.vendored_frameworks = 'MobWithADSDKFramework.xcframework'
  
  s.pod_target_xcconfig = {'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64'}
  s.user_target_xcconfig = {'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64'}
  
  
  s.dependency 'AdFitSDK', '~> 3.12.22'
  
end