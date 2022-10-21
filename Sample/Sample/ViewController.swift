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

    let mediaCode:String = ""
    
    var mobWithAdView:MobWithAdView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        BizBoardTemplate.defaultEdgeInset = UIEdgeInsets.init(top: 8.0, left: 8.0, bottom: 8.0, right: 8.0)
        
        let width = UIScreen.main.bounds.width
        let height = (view.frame.width - (BizBoardTemplate.defaultEdgeInset.left + BizBoardTemplate.defaultEdgeInset.right)) / (1029 / 222) + BizBoardTemplate.defaultEdgeInset.top + BizBoardTemplate.defaultEdgeInset.bottom
        print("\(BizBoardTemplate.defaultEdgeInset)")

        
        mobWithAdView = MobWithAdView.init(CGRect(x: 0, y: 100, width: width, height: height),
                                           type: .BANNER_320x50,
                                           bannerUnitId: mediaCode)
        mobWithAdView?.adDelegate = self
        
        self.view.addSubview(mobWithAdView!)
        
        loadAd()
    }
    
    func loadAd() {
        self.mobWithAdView?.loadAd()
    }
    
    
    @IBAction func clickedLoadAdButton(_ sender: Any) {
        loadAd()
    }
    
}


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
