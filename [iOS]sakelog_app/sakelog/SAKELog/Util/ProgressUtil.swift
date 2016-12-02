//
//  ProgressUtil.swift
//  SAKELog
//
//  Created by taisuke kaneko on 2016/11/27.
//  Copyright © 2016年 金子 太祐. All rights reserved.
//

import Foundation
import SVProgressHUD
import UIKit

class ProgressUtil : NSObject {
    
    static let STATUS_STRING = "読み込み中"
    
    static func showProgress() {
        SVProgressHUD.show(withStatus: STATUS_STRING)
    }
    
    static func closeProgress() {
        SVProgressHUD.dismiss()
    }
    
}
