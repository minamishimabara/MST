//
//  AlertUtil.swift
//  SAKELog
//
//  Created by taisuke kaneko on 2016/11/25.
//  Copyright © 2016年 金子 太祐. All rights reserved.
//

import Foundation
import UIKit

class AlertUtil : NSObject {
    
    
    static func showAlert(from viewController: UIViewController, message: String) {
        let alert: UIAlertController = UIAlertController(title: message, message: "", preferredStyle:  UIAlertControllerStyle.alert)
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:{ (action: UIAlertAction!) -> Void in
            print("OK")
        })
        alert.addAction(defaultAction)
        viewController.present(alert, animated: true, completion: nil)
    }

}
