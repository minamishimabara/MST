//
//  SakeLogData.swift
//  SAKELog
//
//  Created by taisuke kaneko on 2016/11/26.
//  Copyright © 2016年 金子 太祐. All rights reserved.
//

import Foundation
import UIKit

class SakeLogData : NSObject {
    
    //*** From User ***
    var date : String!
    var rate : Int!
    var memo : String!
    
    //*** From Server ***//
    var id : Int!
    var p_name : String!
    var p_furigana : String!
    var p_capacity : String!
    var p_acidity : String!
    var p_nihonshudo : String!
    var b_rice_polish : String!
    var p_best_temperature : String!
    var p_alcohol : String!
    var b_name : String!
    
    //*** Image ***//
    var sakeImage : UIImage!
    var p_image : String!
    
    func allClear() {
        date = ""
        rate = 0
        memo = ""
        
        id = 0
        p_name = ""
        p_furigana = ""
        p_capacity  = ""
        p_acidity = ""
        p_nihonshudo = ""
        b_rice_polish = ""
        p_best_temperature = ""
        p_alcohol = ""
        b_name = ""
        p_image = ""
    }
    
    func outputArray() -> Array<Any> {
        var array : Array<Any> = Array()
        
        array.append(date)
        array.append(rate)
        array.append(memo)
        array.append(p_name)
        array.append(p_furigana)
        array.append(p_capacity)
        array.append(p_nihonshudo)
        array.append(p_acidity)
        array.append(b_rice_polish)
        array.append(p_best_temperature)
        array.append(p_alcohol)
        array.append(b_name)
        array.append(p_image)
        return array
        
    }
    
}
