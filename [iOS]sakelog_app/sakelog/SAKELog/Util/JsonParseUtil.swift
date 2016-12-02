//
//  JsonParseUtil.swift
//  SAKELog
//
//  Created by taisuke kaneko on 2016/11/26.
//  Copyright © 2016年 金子 太祐. All rights reserved.
//

import Foundation

class JsonParseUtil : NSObject {
    
    static func parseResponse(obj: Any?) -> SakeLogData?{
        
        if let dict = obj as? Dictionary<String, Any> {
            let log = SakeLogData()
            log.allClear()
            let now = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss" // 日付フォーマットの設定
            log.date = dateFormatter.string(from: now)
            log.p_name = dict["p_name"] as! String
            log.p_furigana = dict["p_furigana"] as! String
            log.p_capacity = dict["p_capacity"] as! String
            log.p_acidity = dict["p_acidity"] as! String
            log.p_nihonshudo = dict["p_nihonshudo"] as! String
            log.b_rice_polish = dict["p_rice_polish_ratio"] as! String
            log.p_best_temperature = dict["p_best_temperature"] as! String
            log.p_alcohol = dict["p_alcohol"] as! String
            log.b_name = dict["b_name"] as! String
            log.p_image = dict["p_image"] as! String
            return log
        } else {
            return nil
        }
    }
    
}
