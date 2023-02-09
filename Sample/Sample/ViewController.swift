//
//  ViewController.swift
//  Sample
//
//  Created by Enliple on 2022/09/23.
//

import UIKit
import MobWithADSDKFramework
import AdFitSDK

import AdSupport
import AppTrackingTransparency


class ViewController: UIViewController {
    
    let mediaCode320x50:String = "YOUR_ADUNIT_ID"
    let mediaCode300x250:String = "YOUR_ADUNIT_ID"
    
    
    var mobWithAdView:MobWithAdView?
    
    @IBOutlet weak var segmentAdType: UISegmentedControl!
    @IBOutlet weak var idfaLabel: UILabel!
    @IBOutlet weak var versionLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
               
        let version:String = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
        versionLabel.text = "App Version : \(version)"
        
        if #available(iOS 14, *) {
            if ATTrackingManager.trackingAuthorizationStatus == .notDetermined {
                ATTrackingManager.requestTrackingAuthorization { (status) in
                    self.setIdfa()
                }
            }
            else {
                self.setIdfa()
            }
        }
        else {
            setIdfa()
        }
        idfaLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tappedIdfaLabel(gesture:))))
        
        
        segmentAdType.selectedSegmentIndex = 0
    }
    
    func loadAd() {
        self.mobWithAdView?.loadAd()
    }
    
    
    func setIdfa() {
        self.idfaLabel.text = ASIdentifierManager.shared().advertisingIdentifier.uuidString
    }
    
    
    func createAdViewAndLoad() {
        mobWithAdView?.removeFromSuperview()
        mobWithAdView = nil
        
        switch segmentAdType.selectedSegmentIndex {
        case 1:
            let width:CGFloat = 300
            mobWithAdView = MobWithAdView.init(CGRect(x: (UIScreen.main.bounds.width - width) / 2.0, y: 100, width: width, height: 250),
                                               type: .BANNER_300x250,
                                               bannerUnitId: mediaCode300x250)
            
        default:
            let width = UIScreen.main.bounds.width
            mobWithAdView = MobWithAdView.init(CGRect(x: 0, y: 100, width: width, height: 50),
                                               type: .BANNER_320x50,
                                               bannerUnitId: mediaCode320x50)
        }
        
        mobWithAdView?.adDelegate = self
        mobWithAdView?.backgroundColor = UIColor.init(white: 1.0, alpha: 0.5)
        
        self.view.addSubview(mobWithAdView!)
        loadAd()
    }
}



//MARK: - Actions

extension ViewController {
    
    @IBAction func clickedLoadAdButton(_ sender: Any) {
        createAdViewAndLoad()
    }
    
    @IBAction func clickedNextButton(_ sender: Any) {
        mobWithAdView?.showNextAd()
    }
    
    @IBAction func clickedTestNativeADViewButton(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "NativeAdTestViewController")
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
    }
    
    
    
    @objc func tappedIdfaLabel(gesture: UITapGestureRecognizer) {
        UIPasteboard.general.string = self.idfaLabel.text
    }
    
}


//MARK: - MobWithADViewDelegate

extension ViewController: MobWithADViewDelegate {

    func mobWithAdViewDidReceivedAd() {
        // 광고 수신 성공
    }

    func mobWithAdViewDidFailToReceiveAd() {
        // 광고 수신 실패
    }
    
    func mobWithAdViewClickedAd() {
        // 광고 배너 클릭시 발생
    }
}
