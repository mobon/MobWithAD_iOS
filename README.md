# MobMixer iOS SDK

[![CI Status](https://img.shields.io/travis/mobon/MobWithAD.svg?style=flat)](https://travis-ci.org/mobon/MobWithAD)
[![Version](https://img.shields.io/cocoapods/v/MobWithAD.svg?style=flat)](https://cocoapods.org/pods/MobWithAD)
[![License](https://img.shields.io/cocoapods/l/MobWithAD.svg?style=flat)](https://cocoapods.org/pods/MobWithAD)
[![Platform](https://img.shields.io/cocoapods/p/MobWithAD.svg?style=flat)](https://cocoapods.org/pods/MobWithAD)



|지원 환경|
|---:|
| Deployment Target: iOS 12.4 이상 |
| 최신 버전의 Xcode (Xcode 13.0 / Swift 5.3) |

MobWithAD SDK는 Swift로 개발되었습니다. Swift 기반의 프로젝트에서 MobWithAD SDK를 사용하시려면 반드시 최신 버전의 Xcode를 사용해주세요.


## 1. SDK 설치하기
### 1) Cocoapods 사용하여 설치
#### 프로젝트의 Podfile에 'MobWithAD' 를 추가합니다.
```swift
pod 'MobWithAD'
```

### 2) 수동 설치
 - MobWithADSDKFramework.framework를 다운로드 받습니다.  
 - MobWithADSDKFramework.framework를 앱 프로젝트의 General > Embeded Binaries 항목으로 끌어서 놓습니다.  
 - 본 프레임워크는 AdFitSDK의 비즈보드 템플릿을 활용하도록 되어 있습니다. 따라서 AdFitSDK의 추가가 필요합니다. 
   자세한 사항은 [여기](https://github.com/adfit/adfit-ios-sdk/blob/master/Guide/Install%20SDK.md)를 눌러 AdFitSDK의 설치 가이드를 따르시면 됩니다.
 - AdFitSDK 버전은 3.12.7에 최적화 되어 있습니다.



## 2. 프로젝트 설정

### 1) iOS 9 ATS(App Transport Security) 처리
iOS 9부터 ATS(App Transport Security) 기능이 기본적으로 활성화 되어 있으며, 암호화된 HTTPS 방식의 통신만 허용됩니다.  
MobMixer SDK는 ATS 활성화 상태에서도 정상적으로 동작하도록 구현되어 있으나, 광고를 통해 노출되는 광고주 페이지는 HTTPS 방식을 지원하지 않을 수도 있습니다.  
따라서 아래의 사항을 앱 프로젝트의 Info.plist 파일에 적용하여 주시기 바랍니다.  

```swift
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsArbitraryLoads</key>
    <true/>
</dict>
```
### 2) Objective-C 프로젝트
MobWithAD SDK는 Swift 기반으로 개발되었습니다. Objective-C 기반의 프로젝트에서 MobWithAD SDK를 사용하기 위해서는 Swift Standard 라이브러리들을 Embed 시켜주어야 합니다.  
앱 프로젝트의 빌드 세팅에서 Always Embed Swift Standard Libraries 항목을 Yes로 설정해주세요.  


### 3) ATT(App Tracking Transparency) framework 적용
iOS14 타겟팅된 앱은 IDFA 식별자를 얻기 위해서는 ATT Framework를 반드시 적용해야 합니다.

##### 1. 업데이이트 Info.plist
앱이 사용자 또는 장치를 추적하기 위해 데이터 권한을 요청하는 이유를 사용자에게 알리는 메세지를 추가해야 합니다.  
```swift
<key> NSUserTrackingUsageDescription </key>
<string> 맞춤형 광고 제공을 위해 사용자의 데이터가 사용됩니다. </string>
```

##### 2. ATTrackingManager 코드 적용
MobWithAD SDK 사용시 광고 로딩을 위해 loadAD() 함수를 호출하는 경우 자체적으로 해당 부분을 검토 및 권한을 얻도록 구현되어 있습니다.
다만 직접 권한을 얻도록 처리하고자 하는 경우 아래와 같이 제어를 하셔도 무방합니다.
```swift
if #available(iOS 14, *) {
    ATTrackingManager.requestTrackingAuthorization { (status) in
        if status == .authorized {
            mobWithAdView.loadAd()
        }
    }
}
else {
    mobWithAdView.loadAd()
}
```



## 3. 광고 요청

### 1. 프레임워크 import

```swift
import MobWithADSDKFramework		// MobWithAD SDK 추가
import AdFitSDK		    					// AdFitSDK 추가
```



### 2. 광고 요청 및 적용

```swift

let mobMixerView = MobMixerAdView.init(CGRect(x: 0, y: 100, width: width, height: height),
                                       type: .BANNER_320x50,
                                       bannerUnitId: "")
self.view.addSubview(mobMixerView)

mobMixerView.loadAd()
```
현재 지원하는 배너 타입은 아래와 같습니다.

```swift
enum MMBannerType: Int {
    case Banner320x50
}
```



### 3. 광고뷰의 너비 및 높이 설정

본 프레임워크는 AdFitSDK의 비즈보드 템플릿을 사용하도록 되어 있습니다. 따라서 아래와 같이 광고가 표시될 뷰의 크기를 지정해 줄 필요가 있습니다.

``` swift
let width = UIScreen.main.bounds.width
let height = (view.frame.width - BizBoardTemplate.defaultEdgeInset.left + BizBoardTemplate.defaultEdgeInset.right) / (1029 / 222) + BizBoardTemplate.defaultEdgeInset.top + BizBoardTemplate.defaultEdgeInset.bottom

mobWithAdView = MobWithAdView.init(CGRect(x: 0, y: 100, width: width, height: height),
                                          type: .BANNER_320x50,
                                          bannerUnitId: '발급받은 광고 UNIT ID')
```

광고뷰의 너비 및 높이 설정에 대해 더 자세한 사항은 [**AdFitSDK의 비즈보드 템플릿**](https://github.com/adfit/adfit-ios-sdk/blob/master/Guide/BizBoard%20Ad%20Template.md) 의 [**광고뷰의 너비 및 높이 설정**](https://github.com/adfit/adfit-ios-sdk/blob/master/Guide/BizBoard%20Ad%20Template.md#-4-%EA%B4%91%EA%B3%A0%EB%B7%B0%EC%9D%98-%EB%84%88%EB%B9%84-%EB%B0%8F-%EB%86%92%EC%9D%B4-%EC%84%A4%EC%A0%95)과 해당 항목 아래 [**뷰 타입**](https://github.com/adfit/adfit-ios-sdk/blob/master/Guide/BizBoard%20Ad%20Template.md#2-%EB%B7%B0-%ED%83%80%EC%9E%85-uiview-2)을 참조하시면 됩니다.



### 4. MobMixerAdDelegate

광고 수신 성공 또는 실패, 광고 클릭등 상황 발생시 응답을 받고자 하는 경우, MobMixerAdDelegate 프로토콜을 아래와 같이 추가하여 적용하면 됩니다. 

```swift
class ViewController: UIViewController, MobMixerAdDelegate {
  .....
  let mobWithAdView = MobWithAdView.init(CGRect(x: 0, y: 100, width: width, height: height),
                                          type: .BANNER_320x50,
                                          bannerUnitId: '발급받은 광고 UNIT ID')
  mobWithAdView.adDelegate = self
  .....
}
```

각 상황별 아래 Delegate메소드를 통해 필요한 조치를 취하시면 됩니다.

```swift
func mobWithAdViewDidReceivedAd() {
  // 광고 수신 성공
}

func mobWithAdViewDidFailToReceiveAd() {
  // 광고 수신 실패
}

func mobWithAdViewClickedAd() {
  // 광고 배너 클릭시 발생
}
```

