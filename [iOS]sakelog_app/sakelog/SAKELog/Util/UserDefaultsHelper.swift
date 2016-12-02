//
//  UserDefaultsHelper.swift
//  SAKELog
//
//  Created by 金子 太祐 on 2016/11/20.
//  Copyright © 2016年 金子 太祐. All rights reserved.
//

import Foundation

enum SEX : Int{
    case MALE
    case FEMALE
    case OTHER
}
enum AGE : Int{
    case UNDER10
    case GEN10
    case GEN20
    case GEN30
    case GEN40
    case GEN50
    case GEN60
    case OVER60
}

class UserDefaultsHelper : NSObject {
    
    enum USER_DEFAULTS_KEY : String{
        case SEX = "UserDefaultsKey_SEX"
        case AGE = "UserDefaultsKey_AGE"
        case FIRST_LAUNCH = "UserDefaultsKey_FirstLaunch"
        case STAMP = "UserDefaultsKey_STAMP"
    }
    
    static func registDefaults() {
        var defaultDict : [String : Any] = [String : Any]()
        defaultDict.updateValue(true, forKey: USER_DEFAULTS_KEY.FIRST_LAUNCH.rawValue)
        defaultDict.updateValue(0, forKey: USER_DEFAULTS_KEY.STAMP.rawValue)
        UserDefaults.standard.register(defaults: defaultDict)
    }
    
    static var sex : SEX! {
        set{
            UserDefaults.standard.set(newValue.rawValue, forKey: USER_DEFAULTS_KEY.SEX.rawValue)
            UserDefaults.standard.synchronize()
        }
        get{
            switch UserDefaults.standard.integer(forKey: USER_DEFAULTS_KEY.SEX.rawValue) {
            case SEX.MALE.rawValue:
                return SEX.MALE
            case SEX.FEMALE.rawValue:
                return SEX.FEMALE
            case SEX.OTHER.rawValue:
                return SEX.OTHER
            default:
                return nil
            }
        }
    }
    
    static var age : AGE! {
        set{
            UserDefaults.standard.set(newValue.rawValue, forKey: USER_DEFAULTS_KEY.AGE.rawValue)
            UserDefaults.standard.synchronize()
        }
        get{
            switch UserDefaults.standard.integer(forKey: USER_DEFAULTS_KEY.AGE.rawValue) {
            case AGE.UNDER10.rawValue:
                return AGE.UNDER10
            case AGE.GEN10.rawValue:
                return AGE.GEN10
            case AGE.GEN20.rawValue:
                return AGE.GEN20
            case AGE.GEN30.rawValue:
                return AGE.GEN30
            case AGE.GEN40.rawValue:
                return AGE.GEN40
            case AGE.GEN50.rawValue:
                return AGE.GEN50
            case AGE.GEN60.rawValue:
                return AGE.GEN60
            case AGE.OVER60.rawValue:
                return AGE.OVER60
            default:
                return nil
            }
        }
    }
    
    static var stamp : Int {
        set {
            UserDefaults.standard.set(newValue, forKey: USER_DEFAULTS_KEY.STAMP.rawValue)
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.integer(forKey: USER_DEFAULTS_KEY.STAMP.rawValue)
        }
    }
    
    static var isFirstLaunch : Bool {
        set {
            UserDefaults.standard.set(newValue, forKey: USER_DEFAULTS_KEY.FIRST_LAUNCH.rawValue)
            UserDefaults.standard.synchronize()
        }
        get {
            return UserDefaults.standard.bool(forKey: USER_DEFAULTS_KEY.FIRST_LAUNCH.rawValue)
        }
    }
    
}
