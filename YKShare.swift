//
//  Share.swift
//  Share
//
//  Created by 李亚坤 on 14/12/30.
//  Copyright (c) 2014年 李亚坤. All rights reserved.
//

import Foundation
import UIKit

class YKShare {
    

    
    
    class func showCustomShareViewController(ViewController: UIViewController, wechatURL: String?, momentURL: String?, shareURLString: String!, content: String?, imageURLString: String?, defaultImage: UIImage?){
        var shareViewController: ShareViewController!
        var shareView:UIView!
        
        //        if self.newsItem.titleImageURL != nil && newsItem.titleImageURL != ""{
        //            var shareImageURL = NSURL(string: self.newsItem.titleImageURL!)
        //            shareImage = UIImage(data: NSData(contentsOfURL: shareImageURL!)!)
        //        }
        //        else{
        //            shareImage = UIImage(named: "aboutus_avatar")!
        //        }
        

        //设置点击分享内容跳转链接
        //当分享消息类型为图文时，点击分享内容会跳转到预设的链接，设置方法如下
        if  wechatURL != nil && wechatURL != "" {
            UMSocialData.defaultData().extConfig.wechatSessionData.url = wechatURL
        }
        
        if  momentURL != nil && momentURL != "" {
            UMSocialData.defaultData().extConfig.wechatTimelineData.url = momentURL
        }
        


        
        // 自定义的友盟
        if shareViewController == nil {
            shareViewController = ShareViewController(nibName: "ShareViewController", bundle: NSBundle.mainBundle())
            shareView = shareViewController.view
            ViewController.addChildViewController(shareViewController)
            ViewController.view.addSubview(shareView)
            shareView.hidden = true
            shareView.alpha = 0.0
            shareViewController.wechatString = wechatURL
            shareViewController.momentURLString = momentURL
            shareViewController.contentString = content
            shareViewController.shareURLString = shareURLString

            // 如果没有图片，则用默认图片，如果连默认图片，则不用了
            if imageURLString != nil && imageURLString == ""{
                var imageURL = NSURL(string: imageURLString!)
                shareViewController.shareImageURL = imageURLString
                shareViewController.shareImage = UIImage(data: NSData(contentsOfURL: imageURL!)!)
            }
            else
                if defaultImage != nil
                {
                    shareViewController.shareImage = defaultImage!
                }
                else
                    {
                        shareViewController.shareImage = nil
                    }
        }
        
        // 设置自定义友盟界面的约束
        let superview = ViewController.view
        let padding = UIEdgeInsetsMake(0, 0, 0, 0)
        shareViewController.view.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        superview.addConstraints([
            NSLayoutConstraint(
                item: shareView,
                attribute: NSLayoutAttribute.Top,
                relatedBy: NSLayoutRelation.Equal,
                toItem: superview,
                attribute: NSLayoutAttribute.Top,
                multiplier: 1.0,
                constant: padding.top
            ),
            NSLayoutConstraint(
                item: shareView,
                attribute: NSLayoutAttribute.Left,
                relatedBy: NSLayoutRelation.Equal,
                toItem: superview,
                attribute: NSLayoutAttribute.Left,
                multiplier: 1.0,
                constant: padding.left
            ),
            NSLayoutConstraint(
                item: shareView,
                attribute: NSLayoutAttribute.Bottom,
                relatedBy: NSLayoutRelation.Equal,
                toItem: superview,
                attribute: NSLayoutAttribute.Bottom,
                multiplier: 1.0,
                constant: -padding.bottom
            ),
            NSLayoutConstraint(
                item: shareView,
                attribute: NSLayoutAttribute.Right,
                relatedBy: NSLayoutRelation.Equal,
                toItem: superview,
                attribute: NSLayoutAttribute.Right,
                multiplier: 1.0,
                constant: -padding.right
            )
            ])
        
        if shareView.hidden {
            shareView.hidden = false
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                shareView.alpha = 1.0
                }, completion: { (Bool) -> Void in
                    
            })
            
        } else {
            UIView.animateWithDuration(0.3, animations: { () -> Void in
                shareView.alpha = 0.0
                }, completion: { (Bool) -> Void in
                    shareView.hidden = true
            })
        }

    }
}