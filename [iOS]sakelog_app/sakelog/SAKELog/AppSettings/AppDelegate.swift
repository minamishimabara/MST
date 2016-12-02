//
//  AppDelegate.swift
//  SAKELog
//
//  Created by 金子 太祐 on 2016/11/12.
//  Copyright © 2016年 金子 太祐. All rights reserved.
//

import UIKit
import UserNotifications
import CoreLocation

extension Notification.Name {
    static let BeaconRecieve = Notification.Name("BeaconRecieve")
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,CLLocationManagerDelegate {

    var window: UIWindow?
    var beacon : BeaconUtil!
    
    var trigger : Bool = true

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        UserDefaultsHelper.registDefaults()

        beacon = BeaconUtil()
        
        _ = NotificationUtil()
        
        _ = DatabaseUtil.shard
        
        // Debug
        // insertDebug()
        
        // RequestUtil().requestSakeName(withID: "7")
        
        return true
    }    
    
    func applicationWillResignActive(_ application: UIApplication) {}

    func applicationDidEnterBackground(_ application: UIApplication) {}

    func applicationWillEnterForeground(_ application: UIApplication) {}

    func applicationDidBecomeActive(_ application: UIApplication) {}

    func applicationWillTerminate(_ application: UIApplication) {}
    
    
    func insertDebug() {
        let tmp = SakeLogData()
        tmp.allClear()
        tmp.date = "2016/11/26"
        tmp.rate = 1
        tmp.memo = "おいしかった"
        tmp.p_name = "日本酒"
        tmp.p_furigana = "にほんしゅ"
        tmp.p_capacity = "180ml"
        tmp.p_acidity = "0.3"
        tmp.p_nihonshudo = "-1"
        tmp.b_rice_polish = "大吟醸"
        tmp.p_best_temperature = "冷"
        tmp.p_alcohol = "14"
        DatabaseUtil.shard.insertSakeLog(param: tmp.outputArray())
    }


}

