# MobWithAD iOS SDK


|지원 환경|
|---:|
| Deployment Target: iOS 14.0 이상 |
| 최신 버전의 Xcode (Xcode 16.0 / Swift 5.3) |

<br><br>

MobWithAD SDK는 Swift로 개발되었습니다. Swift 기반의 프로젝트에서 MobWithAD SDK를 사용하시려면 반드시 최신 버전의 Xcode를 사용해주세요.
<br><br>

## 최신 버전 및 변경사항
- 최신버전 : 1.2.17
- 변경사항
  - 띠배너에 fillMode 추가 
  - 기타 오류 수정


## 1. SDK 설치하기
### 1) Cocoapods 사용하여 설치
#### 프로젝트의 Podfile에 'MobWithAD' 를 추가합니다.
```swift
// 기본
pod 'MobWithAD', :git => 'https://github.com/mobon/MobWithAD_iOS.git'

// 특정 버전 지정시
pod 'MobWithAD', :git => 'https://github.com/mobon/MobWithAD_iOS.git', :tag => '1.2.17'
```

### 2) 수동 설치

  #### (1) 기본 프레임워크 추가
  - MobWithADSDKFramework.xcframework와 CouOffsiteAds.xcframework를 다운로드 받습니다.  
  - 다운로드 받은 두 Framwork를 앱 프로젝트의 General > Embeded Binaries 항목으로 끌어서 놓습니다.
 
  #### (2) AdFitSDK 추가
  - 본 SDK에서는 AdFitSDK의 비즈보드 템플릿을 활용하도록 되어 있습니다. 따라서 AdFitSDK의 추가가 필요합니다. 
    자세한 사항은 [여기](https://github.com/adfit/adfit-ios-sdk/blob/master/Guide/Install%20SDK.md)를 눌러 AdFitSDK의 설치 가이드를 따르시면 됩니다.
  - AdFitSDK 버전은 3.14.5에 최적화 되어 있습니다.
    
  #### (3) UnitySDK 추가
  - 본 프레임워크는 UnitySDK를 활용하여 광고를 표시하기도 합니다. 
    자세한 사항은 [여기](https://docs.unity.com/ads/ko-kr/manual/InstallingTheUnitySDK)를 눌러 UnitySDK의 설치 가이드를 따르시면 됩니다.
  - UnitySDK 버전은 4.14.1에 최적화 되어 있습니다.
  
  #### (4) PangleSDK 추가
  - 본 프레임워크는 PangleSDK를 활용하여 광고를 표시하기도 합니다. 
    자세한 사항은 [여기](https://www.pangleglobal.com/kr/integration/integrate-pangle-sdk-for-ios)를 눌러 UnitySDK의 설치 가이드를 따르시면 됩니다.
  - PangleSDK 버전은 7.1.1.1에 최적화 되어 있습니다.

<br><br>
## 2. 프로젝트 설정

<br>

### 1) iOS 9 ATS(App Transport Security) 처리
iOS 9부터 ATS(App Transport Security) 기능이 기본적으로 활성화 되어 있으며, 암호화된 HTTPS 방식의 통신만 허용됩니다.  
MobWithAD SDK는 ATS 활성화 상태에서도 정상적으로 동작하도록 구현되어 있으나, 광고를 통해 노출되는 광고주 페이지는 HTTPS 방식을 지원하지 않을 수도 있습니다.  
따라서 아래의 사항을 앱 프로젝트의 Info.plist 파일에 적용하여 주시기 바랍니다.  

```swift
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsArbitraryLoads</key>
    <true/>
</dict>
```
<br>

### 2) Always Embed Swift Standard Libraries 값을 Yes로 설정
앱 Target의 Build Settings 항목에서 Always Embed Swift Standard Libraries값을 Yes로 설정해 줍니다.  


### 3) Objective-C 프로젝트
MobWithAD SDK는 Swift 기반으로 개발되었습니다. Objective-C 기반의 프로젝트에서 MobWithAD SDK를 사용하기 위해서는 Swift Standard 라이브러리들을 Embed 시켜주어야 합니다.  
앱 프로젝트의 빌드 세팅에서 Always Embed Swift Standard Libraries 항목을 Yes로 설정해주세요.  

<br>

### 4) ATT(App Tracking Transparency) framework 적용

iOS14 타겟팅된 앱은 IDFA 식별자를 얻기 위해서는 ATT Framework를 반드시 적용해야 합니다.
 

<br>

####  (1) Info.plist 업데이트
앱이 사용자 또는 장치를 추적하기 위해 데이터 권한을 요청하는 이유를 사용자에게 알리는 메세지를 추가해야 합니다.  
```swift
<key> NSUserTrackingUsageDescription </key>
<string> 맞춤형 광고 제공을 위해 사용자의 데이터가 사용됩니다. </string>
```
<br>

####  (2) ATTrackingManager 코드 적용
1.2.7버전 부터는 IDFA값의 사용을 위한 권한 요청을 직접 진행해 주셔야 합니다. 해당 부분은 아래 코드를 참조 하시면 됩니다. 
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
<br>

### 5) Other Linker 설정
간혹 정상적으로 설정을 하더라도 프레임워크에 대한 설정이 제대로 반영되지 않는 오류가 발생할 수 있습니다.<br>
이러한 경우 BuildSetting -> Other Link에 플래그를 추가해 주어야 합니다.  
대표적으로 추가해야 할 값은 아래와 같습니다.

```swift
  $(inherited)
  -ObjC
  -all_Load
```


<br><br>





## 3. 광고 요청

### 1. 프레임워크 import

```swift
import MobWithADSDKFramework		// MobWithAD SDK 추가
import AdFitSDK   // AdFitSDK 추가 (비즈보드를 사용하는 경우, 여백 설정을 위해 필요합니다)
```
<br>

### 2. SDK 초기화
```swift
MobWithADSDK.standard.initSDK()
MobWithADSDK.standard.initSDK(coupangSubId: "{전달받은 쿠팡 Sub ID}")  // 쿠팡 SDK 광고 사용시에만 설정
MobWithADSDK.standard.setUnityGameId(gameId: "{전달받은 Unity Game ID}") //유니티 SDK 광고 사용시에만 설정
MobWithADSDK.standard.setLevelPlaySDKAppKey("{전달받은 LevelPlay AppKey}") //레벨플레이 SDK 광고 사용시에만 설정
MobWithADSDK.standard.setPangleAppId(appId: "{전달받은 Pangle App ID}")  // Pangle SDK 광고 사용시에만 설정
```


<br>

### 3. 광고 요청 및 적용

```swift

let mobWithAdView = MobWithAdView.init(CGRect(x: 0, y: 100, width: width, height: height),
                                          type: .BANNER_320x50,
                                          bannerUnitId: '발급받은 광고 UNIT ID')
self.view.addSubview(mobWithAdView)

mobWithAdView.loadAd()
```
현재 지원하는 배너 타입은 아래와 같습니다.

```swift
enum MMBannerType: Int {
    case Banner320x50
    case Banner320x100
    case Banner300x250
}
```
<br>

#### 1) 광고 자동 갱신
아래 예시처럼 MobWithAdView의 interval을 60이상으로 설정하면 배너 광고가 설정된 시간마다 자동으로 갱신 됩니다.  
설정되는 값은 '초'(Second)값이며, 최소 60초 이상으로 설정하셔야 합니다.  
0으로 설정 하시는 경우 자동 갱신이 동작하지 않으며 60보다 작은 값을 설정하는 경우 60초 마다 동작합니다.
```swift
mobWithAdView?.interval = 60
```


#### 2) 광고 자동 갱신 정지 및 재시작
광고 자동 갱신의 정지 및 재시작은 아래 명령어를 참고 하시면 됩니다.
```swift
mobWithAdView?.stop()       // 광고 자동 갱신 중지
mobWithAdView?.restart()    // 광고 자동 갱신 재시작
```
  
<br>

### 4. 광고뷰의 너비 및 높이 설정
#### 1. 공통
광고를 표시할 뷰의 사이즈는 아래와 같이 지정된 BannerType의 크기와 동일해야 합니다.  
(fillMode를 true로 적용하지 않은 경우)

``` swift
mobWithAdView = MobWithAdView.init(CGRect(x: 0, y: 100, width: 320, height: 50),
                                          type: .BANNER_320x50,
                                          bannerUnitId: '발급받은 광고 UNIT ID')
```

#### 2. AdFit 비즈보드 이용시
비즈보드 광고의 경우 기본으로 여백이 할당 되도록 구현되어 있습니다.  따라서 광고 뷰 생성 및 로드를 하기전 아래의 코드를 참고하여 필요에 따라 여백을 설정해줄 필요가 있습니다.
``` swift
...
BizBoardTemplate.defaultEdgeInset = UIEdgeInsets.init(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
...
```

또한, 비즈보드에서 광고 표시를 위해 요구하는 광고 뷰의 사이즈 비율이 있습니다. 아래는 해당 비율로 광고를 적용하기 위한 방법입니다.
* 1.2.0 버전 부터는 사용자가 지정한 화면 사이즈에 대응 하여 광고가 표시될 수 있도록 개선되었으니 아래는 참고만 하셔도 됩니다.

``` swift
let width = UIScreen.main.bounds.width
let height = (view.frame.width - BizBoardTemplate.defaultEdgeInset.left + BizBoardTemplate.defaultEdgeInset.right) / (1029 / 258) + BizBoardTemplate.defaultEdgeInset.top + BizBoardTemplate.defaultEdgeInset.bottom

mobWithAdView = MobWithAdView.init(CGRect(x: 0, y: 100, width: width, height: height),
                                          type: .BANNER_320x50,
                                          bannerUnitId: '발급받은 광고 UNIT ID')
```

광고뷰의 너비 및 높이 설정에 대해 더 자세한 사항은 [**AdFitSDK의 비즈보드 템플릿**](https://github.com/adfit/adfit-ios-sdk/blob/master/Guide/BizBoard%20Ad%20Template.md) 의 [**광고뷰의 너비 및 높이 설정**](https://github.com/adfit/adfit-ios-sdk/blob/master/Guide/BizBoard%20Ad%20Template.md#-4-%EA%B4%91%EA%B3%A0%EB%B7%B0%EC%9D%98-%EB%84%88%EB%B9%84-%EB%B0%8F-%EB%86%92%EC%9D%B4-%EC%84%A4%EC%A0%95)과 해당 항목 아래 [**뷰 타입**](https://github.com/adfit/adfit-ios-sdk/blob/master/Guide/BizBoard%20Ad%20Template.md#2-%EB%B7%B0-%ED%83%80%EC%9E%85-uiview-2)을 참조하시면 됩니다.



#### 3. fillMode
fillMode를 true로 설정하시면 지정한 사이즈를 최대한 활용하게 됩니다. 기본값은 false 입니다.  
다만 실제 노출될 광고의 비율과 지정한 영역의 비율이 맞지 않는 경우 남는 공간에 대해 여백이 발생 할 수 있으니,  
가급적 비율은 동일하게 맞출 것을 권장 드립니다.

<br><br>


### 5. MobWithADViewDelegate

광고 수신 성공 또는 실패, 광고 클릭등 상황 발생시 응답을 받고자 하는 경우, MobWithADViewDelegate 프로토콜을 아래와 같이 추가하여 적용하면 됩니다. 

```swift
class ViewController: UIViewController, MobWithADViewDelegate {
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

<br><br>

## 4. MMNativeAdView
MMNativeAdView 사용자가 직접 뷰를 설정하고, 설정된 뷰를 SDK에서 전달받아 각각의 view에 광고 데이터를 설정해주는 기능만 담당하는 AdView입니다.  설정된 View를 확인하지 못하는 경우 광고가 제대로 표시되지 않을 수 있으니 주의 바랍니다.

### 1) 광고 호출방법
```swift

var nativeAdView = MMNativeAdView(bannerUnitId: mediaCode,
                                  adContainerView: adContainerView,
                                  nativeAdRootView: nativeAdRootView,
                                  adImageView: thumbnailImageView,
                                  logoImageView: logoImageView,
                                  titleLabel: titleLabel,
                                  descriptionLabel: descLabel,
                                  gotoSiteButton: goButton,
                                  infoLogoImageView: infoLogoImageView)
nativeAdView?.adDelegate = self
nativeAdView?.loadAd()

```

### 2) 광고 클릭 버튼을 사용하지 못하는 경우 
```swift
nativeAdView?.performAdClicked()

```
위 메소드를 호출하여 광고를 클릭한 것과 동일한 효과를 줄 수 있습니다.

<br><br>

## 5. MobWithNativeAdLoader 광고 예제
MobWithNativeAdLoader는 MMNativeAdView를 리스트 타입의 뷰에 노출 하고자 할 때 적용 가능한 기능 입니다.

<br>

### 1. 광고 로드 방법

먼저 광고를 표시하기 위한 View를 생성합니다.  이때 해당 Views는 MobwithNativeAdViewRender를 extension하여 각 메소드들을 정의해 주어야 하며, AppLovin을 사용하시는 경우 MANativeAdView를 상속 받은 상태여야 합니다.

```swift
class NativeAdLoaderView: MANativeAdView {
    static let needHeight:CGFloat = 347.0
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var infoLogoImageView: UIImageView!
    
    @IBOutlet weak var adTitleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var goButton: UIButton!
        
}

extension NativeAdLoaderView: MobwithNativeAdViewRender {
    
    func getAdImageView() -> UIImageView? {
        return thumbnailImageView
    }
    
    func getAdLogoImageView() -> UIImageView? {
        return logoImageView
    }
    
    func getAdTitleLabel() -> UILabel? {
        return adTitleLabel
    }
    
    func getAdDescriptionLabel() -> UILabel? {
        return descLabel
    }
    
    func getGoToSiteButton() -> UIButton? {
        return goButton
    }
    
    func getInfoLogoImageView() -> UIImageView? {
        return infoLogoImageView
    }
    
}
```
<br>

다음으로 광고를 불러오기 위해 MobWithNativeAdLoader는를 생성 및 초기화를 진행해 줍니다.  여기에 위에서 생성해 두었던 광고를 표시할 View를 넘겨 주도록 합니다.
```swift

//MobwithNativeAdLoader 생성
let mediaCodes:[String] = [ "광고 Unit ID" ] //1개 이상의 Unit를 설정해 주어야 합니다.
var nativeAdLoader = MobWithNativeAdLoader(unitIds: mediaCodes, nibName: "NativeAdLoaderView", bundle: nil)
nativeAdLoader.nativeAdLoaderDelegate = self
//광고를 표시할 View 설정
adLoader.setNativeADView(this,
      R.layout.custom_native_ad_view,
      R.id.mediaContainerView,
      R.id.imageViewAD,
      R.id.imageViewLogo,
      R.id.textViewTitle,
      R.id.textViewDesc,
      R.id.buttonGo,
      R.id.infoViewLayout,
      R.id.imageViewInfo);


.......

```
<br> 

이후 UITableView등 리스트 타입 View에서 아래와 같이 광고View를 받아와서 화면에 노출되도록 합니다.

```swift

...

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
  if (indexPath.row % 5 == 4) {
    let cell:UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "NativeADCellID", for: indexPath)
    
    // loadAD()를 호출하면 이미 로드된 광고가 있거나 이미 생성된 뷰가 있는 경우 해당 View를 전달해 줍니다.
    // isLoadedAd()를 호출하면 광고를 받아온 경우 true를 반환합니다. 해당 값을 확인후 뷰에 추가하는것을 권장드립니다.
    if let adView = nativeAdLoader.loadAd(At: indexPath), nativeAdLoader.isLoadedAd(At: indexPath) {
      cell?.addSubview(adView)
                
      adView.translatesAutoresizingMaskIntoConstraints = false
      cell?.widthAnchor.constraint(equalTo: adView.widthAnchor).isActive = true
      cell?.heightAnchor.constraint(equalTo: adView.heightAnchor).isActive = true
      cell?.centerXAnchor.constraint(equalTo: adView.centerXAnchor).isActive = true
      cell?.centerYAnchor.constraint(equalTo: adView.centerYAnchor).isActive = true
    }
    else {
      if nativeAdLoader.isFailLoadAd(At: indexPath) {
        nativeAdLoader.retryLoadAd(At: indexPath)
      }
                
      cell?.subviews.forEach({ view in
        (view as? NativeAdLoaderView)?.removeFromSuperview()
      })
    }

    return cell ?? UITableViewCell.init()
  }
  else {
    ...
  }

...

```

<br>
<br>

## 6. MobWithInterstitailAd (전면배너 광고)
화면에 전면배너를 표시 합니다.  자세한 사용법은 아래를 참고 하시면 됩니다.

```swift

let interstitialAd = MobWithInterstitailAd.init()
interstitialAd.rootViewController = self
interstitialAd.adDelegate = self
interstitialAd.unitId = "{전달 받은 지면번호}"

//지면번호 설정후 광고 요청, 광고 요청에 성공한 이후 show() 함수를 이용하여 광고를 화면에 표시 할 수 있습니다.
interstitialAd.loadAd()


extension ViewController: MobWithIntersitialAdDelegate {

    func mobWithIntersitialAdDidReceived(_ interstitialAd: MobWithInterstitailAd?) {
      // 광고 수신 성공, 해당 메세지를 받은 이후 광고 오픈을 해야 합니다.
    }

    func mobWithIntersitialAdDidFailToReceive(_ interstitialAd: MobWithInterstitailAd?) {
      // 광고 수신 실패
    }

    func mobWithIntersitialAdClicked(_ interstitialAd: MobWithInterstitailAd?) {
      // 광고 클릭
    }

    func mobWithIntersitialAdDidOpend(_ interstitialAd: MobWithInterstitailAd?) {
      // 광고 오픈 성공
    }

    func mobWithIntersitialAdDidClosed(_ interstitialAd: MobWithInterstitailAd?) {
      // 광고 창을 닫은 경우 호출됨
    }
}

```

<br>
<br>




## 7. MobWithRewardAd (리워드 광고)
리워드 광고는 광고를 본 사용자에게 리워드를 제공하기 위한 기능을 제공하는 광고 입니다.
사용법은 아래를 참고 하시면 됩니다.

```swift
let rewardAd = MobWithRewardAd.init()
rewardAd.rootViewController = self
rewardAd.adDelegate = self
rewardAd.unitId = "{전달 받은 지면번호}"

//지면번호 설정후 광고 요청, 광고 요청에 성공한 이후 show() 함수를 이용하여 광고를 화면에 표시 할 수 있습니다.
rewardAd.loadAd()


//리워드 광고에 대한 콜백은 MobWithRewardAdDelegate를 통해 전달 받을 수 있습니다.
extension ViewController: MobWithRewardAdDelegate {
    
    func mobWithRewardAdDidReceived(_ rewardAd: MobWithRewardAd?) {
      // 광고 수신 성공.  해당 메세지를 받은 이후 광고 오픈을 해야 합니다.
    }
    
    func mobWithRewardAdDidFailToReceive(_ rewardAd: MobWithRewardAd?) {
      // 광고 수신 실패시
    }
    
    func mobWithRewardAdDidOpend(_ rewardAd: MobWithRewardAd?) {
      // 광고 오픈 성공
    }
    
    
    func mobWithRewardAdDidOpenFailed(_ rewardAd: MobWithRewardAd?) {
      // 광고 오픈 실패
    }
    
    func mobWithRewardAdClicked(_ rewardAd: MobWithRewardAd?) {
      // 광고 클릭
    }
    
    
    func mobWithRewardAdCanReward(_ rewardAd: MobWithRewardAd?) {
      // 광고를 통한 리워드 조건 충족
    }
    
    func mobWithRewardAdClosed(_ rewardAd: MobWithRewardAd?) {
      // 광고 창을 닫은 경우 호출됨
    }
}

```

<br>
<br>


* 더 자세한 사항은 Sample앱을 참고 하시기 바랍니다.
<br>
<br>
