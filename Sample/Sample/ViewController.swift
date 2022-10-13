//
//  ViewController.swift
//  Sample
//
//  Created by Enliple on 2022/09/23.
//

import UIKit
import MobMixerFramework
import AdFitSDK

import AdSupport
import AppTrackingTransparency


class ViewController: UIViewController {

    let UNIT_ID:String = ""
    
    var mobMixerView:MobMixerAdView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let width = UIScreen.main.bounds.width
        let height = (view.frame.width - BizBoardTemplate.defaultEdgeInset.left + BizBoardTemplate.defaultEdgeInset.right) / (1029 / 222) + BizBoardTemplate.defaultEdgeInset.top + BizBoardTemplate.defaultEdgeInset.bottom

        
        mobMixerView = MobMixerAdView.init(CGRect(x: 0, y: 100, width: width, height: height),
                                           type: .BANNER_320x50,
                                           bannerUnitId: UNIT_ID)
        mobMixerView?.adDelegate = self
        
        self.view.addSubview(mobMixerView!)
        
        loadAd()
    }
    
    func loadAd() {
        self.mobMixerView?.loadAd()
    }
    
    
    @IBAction func clickedLoadAdButton(_ sender: Any) {
        loadAd()
    }
    
}


extension ViewController: MobMixerAdDelegate {

    func mobMixerDidReceivedAd() {
        // 광고 수신 성공
        print("광고 수신 성공")
    }

    func mobMixerDidFailToReceiveAd() {
        // 광고 수신 실패
        print("광고 수신 실패")
    }

    func mobMixerClickedAd() {
        // 광고 배너 클릭시 발생
        print(" 광고 배너 클릭")
    }
}
