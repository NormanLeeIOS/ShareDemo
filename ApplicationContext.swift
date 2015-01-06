//
//  ApplicationContext.swift
//  ArabianApp
//
//  Created by 李亚坤 on 14/12/30.
//  Copyright (c) 2014年 李亚坤. All rights reserved.
//

import UIKit

class ApplicationContext {
    
    //单例模式，如果需要可用
    //参考了：http://stackoverflow.com/questions/24024549/dispatch-once-singleton-model-in-swift
    class var sharedInstance:ApplicationContext{
        struct Singleton{
            static let instance = ApplicationContext()
        }
        return Singleton.instance
    }
    
    class func pushToState(stateName:String,parameters:[String:AnyObject]?=nil, delayTime:Double=0){
        delay(delayTime){
            var userInfo: Dictionary<String, AnyObject> = Dictionary()
            if let paramDict = parameters {
                for (key, value) in paramDict {
                    userInfo[key] = value
                }
            }
            
            userInfo["state"] = stateName
            NSNotificationCenter.defaultCenter().postNotificationName("pushToState", object: self, userInfo:userInfo)
        }
    }
    
    class func popBack(delayTime:Double=0){
        delay(delayTime){
            NSNotificationCenter.defaultCenter().postNotificationName("popBack", object: self, userInfo:nil)
        }
    }
    
    class func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    
    class func JSONObject(data: NSData) -> AnyObject? {
        return NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: nil)
    }
}