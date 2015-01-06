//
//  ShareViewController.swift
//  ArabianApp
//
//  Created by 李亚坤 on 14/12/30.
//  Copyright (c) 2014年 李亚坤. All rights reserved.
//



class ShareViewController: UIViewController, UMSocialUIDelegate{


    @IBOutlet weak var shareView: UIView!
    @IBOutlet weak var sinaView: UIView!
    @IBOutlet weak var tencentView: UIView!
    @IBOutlet weak var wechatView: UIView!
    @IBOutlet weak var friendroundView: UIView!
    @IBOutlet weak var facebookView: UIView!
    @IBOutlet weak var twiiterView: UIView!
    
    var wechatString: String!
    var momentURLString: String!
    var contentString: String!
    var shareImageURL: String!
    var shareImage: UIImage!
    var shareURLString: String!

 
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "customShare:", name: "customShare", object: nil)
        println("添加观察者")
        

        // Do any additional setup after loading the view.
    }

    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func back(sender: AnyObject)
    {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "customShare", object: nil)
        println("已删除观察者")
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.view.alpha = 0.0
            }, completion: { (Bool) -> Void in
                self.view.hidden = true
        })
    }

    @IBAction func onClickSinaButton(sender: AnyObject) {
        NSNotificationCenter.defaultCenter().postNotificationName("customShare", object: nil, userInfo: ["index": "1"])
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.view.alpha = 0.0
            }, completion: { (Bool) -> Void in
                self.view.hidden = true
        })
      //  NSNotificationCenter.defaultCenter().removeObserver(self, name: "customShare", object: nil)
    }
    
    @IBAction func onClickTencentButton(sender: AnyObject) {
       NSNotificationCenter.defaultCenter().postNotificationName("customShare", object: nil, userInfo: ["index": "2"])
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.view.alpha = 0.0
            }, completion: { (Bool) -> Void in
                self.view.hidden = true
        })
        //NSNotificationCenter.defaultCenter().removeObserver(self, name: "customShare", object: nil)
    }
    
    @IBAction func onClickWechatButton(sender: AnyObject) {
       // NSNotificationCenter.defaultCenter().postNotificationName("customShare", object: nil, userInfo: ["index": "3"])
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.view.alpha = 0.0
            }, completion: { (Bool) -> Void in
                self.view.hidden = true
        })
        //NSNotificationCenter.defaultCenter().removeObserver(self, name: "customShare", object: nil)
    }
    
    @IBAction func onClickFriendroundButton(sender: AnyObject) {
      // NSNotificationCenter.defaultCenter().postNotificationName("customShare", object: nil, userInfo: ["index": "4"])
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.view.alpha = 0.0
            }, completion: { (Bool) -> Void in
                self.view.hidden = true
        })
        //NSNotificationCenter.defaultCenter().removeObserver(self, name: "customShare", object: nil)
    }
    
    @IBAction func onClickFacebookButton(sender: AnyObject) {
       NSNotificationCenter.defaultCenter().postNotificationName("customShare", object: nil, userInfo: ["index": "5"])
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.view.alpha = 0.0
            }, completion: { (Bool) -> Void in
                self.view.hidden = true
        })
        //NSNotificationCenter.defaultCenter().removeObserver(self, name: "customShare", object: nil)
    }
    
    @IBAction func onClickTwiiterButton(sender: AnyObject) {
      //  NSNotificationCenter.defaultCenter().postNotificationName("customShare", object: nil, userInfo: ["index": "6"])
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.view.alpha = 0.0
            }, completion: { (Bool) -> Void in
                self.view.hidden = true
        })
    }
    
    // 自定义分享功能实现
    // 感谢宋志明的贡献
    func customShare(notification : NSNotification){
        
        switch (notification.userInfo?["index"] as String)
        {
        case "1":
            UMSocialControllerService.defaultControllerService().setShareText(contentString, shareImage: shareImage, socialUIDelegate: self)
            UMSocialSnsPlatformManager.getSocialPlatformWithName(UMShareToSina).snsClickHandler(self, UMSocialControllerService.defaultControllerService(), true)
            break
        case "2":
            UMSocialControllerService.defaultControllerService().setShareText(contentString, shareImage: shareImage, socialUIDelegate: self)
            UMSocialSnsPlatformManager.getSocialPlatformWithName(UMShareToTencent).snsClickHandler(self, UMSocialControllerService.defaultControllerService(), true)
            break
        case "3":
            UMSocialDataService.defaultDataService().postSNSWithTypes([UMShareToWechatSession as AnyObject!], content: contentString, image: shareImage, location: nil, urlResource: nil, presentedController:self, completion: {
                (response: UMSocialResponseEntity?) in
                if response!.responseCode.value == UMSResponseCodeSuccess.value {
                    HYBProgressHUD.showSuccess("Success!")
                }
                else{
                    HYBProgressHUD.showError("Failed!")
                }
            })
            break
        case "4":
            UMSocialDataService.defaultDataService().postSNSWithTypes([UMShareToWechatTimeline as AnyObject!], content: contentString, image: shareImage, location: nil, urlResource: nil, presentedController:self, completion: {
                (response: UMSocialResponseEntity?) in
                if response!.responseCode.value == UMSResponseCodeSuccess.value {
                    HYBProgressHUD.showSuccess("Compartido!")
                }
                else{
                    HYBProgressHUD.showError("No se puede compartir de momento")
                }
            })
            break
        case "5":
            self.shareFaceBook()
            break
        case "6":
            UMSocialControllerService.defaultControllerService().setShareText(contentString, shareImage: shareImage, socialUIDelegate: self)
            UMSocialSnsPlatformManager.getSocialPlatformWithName(UMShareToTwitter).snsClickHandler(self, UMSocialControllerService.defaultControllerService(), true)
            break
        default:
            break
        }
    }
    
    func didFinishGetUMSocialDataInViewController(response: UMSocialResponseEntity!) {
        println("response:\(response)")
        
        if response.responseCode.value == UMSResponseCodeSuccess.value{
            HYBProgressHUD.showSuccess("Success!")
        }
        else{
            HYBProgressHUD.showError("Failed!")
        }
    }
    
    
    func shareFaceBook()
    {
        
        var params = FBLinkShareParams()
        
        params.link = NSURL(string: shareURLString!)
        params.linkDescription = contentString
        
        println("prarms.link:\(params.link)")
        if shareImageURL == nil || shareImageURL == ""
        {
            params.picture = nil
        }
        else{
            params.picture = NSURL(string: shareImageURL!)
        }
        // If the Facebook app is installed and we can present the share dialog
        if  FBDialogs.canPresentShareDialogWithParams(params) == true
        {
            FBDialogs.presentShareDialogWithLink(params.link, handler: {
                call, results, error in
                if error != nil{
                    HYBProgressHUD.showError("Failed!")
                }
                else{
                    HYBProgressHUD.showSuccess("Success!")
                }
            })
        }
        else
        {
            
            // FALLBACK: publish just a link using the Feed dialog
            // Put together the dialog parameters
            var paramsDic = [
                "description": params.linkDescription,
                "link": shareURLString,
            ]
            if params.picture != nil
            {
                paramsDic = [
                    "description": params.linkDescription,
                    "link": shareURLString,
                    "picture": shareImageURL]
            }
            
            
            println("parametersparametersparameters==>>>\(paramsDic)")
            
            // show the feed dialog
            FBWebDialogs.presentFeedDialogModallyWithSession(nil, parameters: paramsDic, handler: {
                result, resultURL, error in
                println(error)
                if  error != nil
                {
                    HYBProgressHUD.showError("Failed!")
                }
                else
                {
                    HYBProgressHUD.showSuccess("Success!")
                }
            })
        }
    }
    
    
    
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.Portrait.rawValue)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
