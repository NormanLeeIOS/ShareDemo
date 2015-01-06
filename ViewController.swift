//
//  ViewController.swift
//  Share
//
//  Created by 李亚坤 on 14/12/30.
//  Copyright (c) 2014年 李亚坤. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //分享部分增加观察者
        //NSNotificationCenter.defaultCenter().addObserver(self, selector: "customShare:", name: "customShare", object: nil)
        
    }
    // 关闭通知
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(true)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "customShare", object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func customShare(sender: AnyObject) {
        
        YKShare.showCustomShareViewController(self, wechatURL: nil, momentURL: nil, shareURLString: "www.baidu.com", content: "百度", imageURLString: "http://images.china.cn/attachement/jpg/site1001/20141215/00016c42b3f515f8eb9601.jpg", defaultImage: nil)
        
    }//share
    

}

