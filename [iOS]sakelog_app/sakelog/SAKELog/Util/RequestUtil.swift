//
//  RequestUtil.swift
//  SAKELog
//
//  Created by taisuke kaneko on 2016/11/26.
//  Copyright © 2016年 金子 太祐. All rights reserved.
//

import Foundation
import AFNetworking

class RequestUtil : NSObject {
    
    var manager : AFHTTPSessionManager!
    
    let BASE_URL : String = "http://116.118.233.143/"
    let PATH_URL : String = "mst/get_product.php"
    
    override init(){
        manager = AFHTTPSessionManager()
    }
    
    func requestSakeName(withID: String){
        
        let param = ["id" : withID]
        let urlString = BASE_URL + PATH_URL
        
        manager.get(urlString, parameters: param, progress: nil, success:{(task, obj) -> Void in
            print(obj)
            let newSakeLog = JsonParseUtil.parseResponse(obj: obj!)!
            DatabaseUtil.shard.insertSakeLog(param: (newSakeLog.outputArray()))
        }, failure: {(task, error) in
            print(error)
        })
        
    }
    
}
