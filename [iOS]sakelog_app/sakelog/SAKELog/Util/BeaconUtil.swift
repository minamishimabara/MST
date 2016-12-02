//
//  BeaconUtil.swift
//  SAKELog
//
//  Created by taisuke kaneko on 2016/11/25.
//  Copyright © 2016年 金子 太祐. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

class BeaconUtil : NSObject, CLLocationManagerDelegate {
    
    var locationManager : CLLocationManager!
    var proximityUUID : UUID!
    
    var beaconRegion : CLBeaconRegion!
    
    var appDelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var stringUUID01 = "9E88CA83-DC2F-4413-8E8B-FD28F653E768"
    var stringAppBundleID = "jp.mst.sakeLogDev"
        
    override init(){
        super.init()
        
        if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.classForCoder()) {
            
            locationManager = CLLocationManager()
            locationManager.delegate = self
            
            // セキュリティ認証のステータスを取得
            let status = CLLocationManager.authorizationStatus()
            
            // まだ認証が得られていない場合は、認証ダイアログを表示
            if status == CLAuthorizationStatus.notDetermined {
//                print("didChangeAuthorizationStatus:\(status)");
                // まだ承認が得られていない場合は、認証ダイアログを表示
                locationManager.requestAlwaysAuthorization()
            }
            proximityUUID = UUID(uuidString: stringUUID01)
            beaconRegion = CLBeaconRegion(proximityUUID: proximityUUID!, identifier: stringAppBundleID)
            // 入域通知の設定.
            beaconRegion.notifyOnEntry = true
            // 退域通知の設定.
            beaconRegion.notifyOnExit = true
            
            beaconRegion.notifyEntryStateOnDisplay = true
        }

    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        print("didChangeAuthorization")
        locationManager.startMonitoring(for: beaconRegion)
    }
    
    func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
//        print("didStartMonitoringForRegion")
        //観測開始に成功したら、領域内にいるかどうかの判定をおこなう。→（didDetermineState）へ
        locationManager.requestState(for: beaconRegion)
    }
    
    //func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for inRegion: CLRegion) {
    func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion) {
//        print("didDetermineState")
        switch (state) {
        case .inside:
            // すでに領域内にいる場合は（didEnterRegion）は呼ばれない
            locationManager.startRangingBeacons(in: beaconRegion)
        case .outside: break
        // 領域外→領域に入った場合はdidEnterRegionが呼ばれる
        case .unknown: break
            // 不明→領域に入った場合はdidEnterRegionが呼ばれる
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
//        print("didRangeBeacons")
        if beacons.count > 0 {
            for beacon in beacons {
                
//                print("UUID: \(beacon.proximityUUID.uuidString)");
//                print("minorID: \(beacon.minor)");
//                print("majorID: \(beacon.major)");
//                print("RSSI: \(beacon.rssi)");
                
                switch (beacon.proximity) {
                    
                case .unknown : break
//                    print("Proximity: Unknown");
                case .far: break
//                    print("Proximity: Far");
                case .near: break
//                    print("Proximity: Near");
                case .immediate: 
//                    print("Proximity: Immediate");
                    if !appDelegate.trigger {
                        UserDefaultsHelper.stamp = UserDefaultsHelper.stamp + 1
                        appDelegate.trigger = true
                    }
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
//        print("didEnterRegion")
        locationManager.startRangingBeacons(in: beaconRegion)
        //NotificationUtil().sendLocalNotification(message: "酒蔵に入りました！")
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
//        print("didExitRegion")
        NotificationUtil().sendLocalNotification(message: "酒蔵から出ました！")
        //locationManager.stopRangingBeacons(in: beaconRegion)
    }
    
}
