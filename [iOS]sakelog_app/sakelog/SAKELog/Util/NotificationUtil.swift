//
//  NotificationUtil.swift
//  SAKELog
//
//  Created by taisuke kaneko on 2016/11/25.
//  Copyright © 2016年 金子 太祐. All rights reserved.
//

import Foundation
import UserNotifications
import UIKit

class NotificationUtil : NSObject, UNUserNotificationCenterDelegate {
    
    override init(){
        super.init()
        
        UIApplication.shared.cancelAllLocalNotifications()
        
        if #available(iOS 10.0, *) {
            // iOS 10
            let center = UNUserNotificationCenter.current()
            center.delegate = self
            center.requestAuthorization(options: [.badge, .sound, .alert], completionHandler: { (granted, error) in
            })
        } else {
            // iOS 9
            let settings = UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(settings)
        }
    }
    func sendLocalNotification(message: String){
        if #available(iOS 10.0, *) {
            let content = UNMutableNotificationContent()
            content.title = ""
            content.subtitle = ""
            content.body = message
            content.sound = UNNotificationSound.default()
            let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: 0.1, repeats: false)
            let request = UNNotificationRequest(identifier: "SampleRequest", content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().delegate = self
            UNUserNotificationCenter.current().add(request){ (error) in
                if (error != nil){
                    print(error!)
                }
            }
        } else {
            let localNotification = UILocalNotification()
            localNotification.alertBody = message
            localNotification.fireDate = Date()
            localNotification.timeZone = NSTimeZone.default
            localNotification.soundName = UILocalNotificationDefaultSoundName
            UIApplication.shared.scheduledLocalNotifications?.append(localNotification)
        }
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
//        print("Tapped in notification")
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
//        print("Notification being triggered")
        if notification.request.identifier == "SampleRequest"{
            completionHandler( [.alert,.sound,.badge])
            
        }
    }

}
