ShareDemo
=========

分享用例
ShareDemo

－简介

－功能

－如何使用－ 简介

首先，我只做了自定义分享，至于友盟自己的分享的View，一句话就OK了，但是我不建议用。

关于我的自定义分享，界面如下：
git地址：git@github.com:NormanLeeIOS/ShareDemo.git－ 功能

支持分享到FaceBook（包括安装客户端和未安装客户端）
支持分享到新浪微博
支持分享到腾讯微博
支持分享到推特（包括安装客户端和未安装客户端）
分享到微信、朋友圈需要在plist添加ID
支持横屏效果－ 如何使用

－facebook
1、 首先到https://developers.facebook.com/先注册你的应用
2、 注册好以后，获得一个app ID，然后进入Getting Started
3、然后跳转的页面已经接近手把手操作了。不再详述。这里说下如何使用我的这个Demo。
4、首先进入Info.plist修改这三个参数。
5、配置好appdelegate.swift
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        navigationController = self.window!.rootViewController as UINavigationController
        
        
        // 需要自行添加的东西
        //设置友盟社会化组件appkey
        UMSocialData.setAppKey("54a20e8bfd98c585620001fb")
        
        //打开调试log的开关
        UMSocialData.openLog(true)
        
        //如果你要支持不同的屏幕方向，需要这样设置，否则在iPhone只支持一个竖屏方向
        UMSocialConfig.setSupportedInterfaceOrientations(UIInterfaceOrientationMask.All)
        
        //设置微信AppId，设置分享url，默认使用友盟的网址
        UMSocialWechatHandler.setWXAppId("wxd930ea5d5a258f4f", appSecret: "db426a9829e4b49a0dcac7b4162da6b6", url: nil)
        
        //设置facebook应用ID，和分享纯文字用到的url地址
      //  UMSocialFacebookHandler.setFacebookAppID("91136964205", shareFacebookWithURL: nil)
        
        //打开twitter
        UMSocialTwitterHandler.openTwitter()
        return true
    }

    
    /**
    这里处理新浪微博SSO授权之后跳转回来，和微信分享完成之后跳转回来
    */
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool {
        return UMSocialSnsService.handleOpenURL(url)
    }


    func applicationDidBecomeActive(application: UIApplication) {

        /**
        这里处理新浪微博SSO授权进入新浪微博客户端后进入后台，再返回原来应用
        */
        UMSocialSnsService.applicationDidBecomeActive()
    }


配置好桥接文件。输入以下头文件
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialTwitterHandler.h"
#import "UMSocialQQHandler.h"
#import "UMSocialSinaHandler.h"
#import <FacebookSDK/FacebookSDK.h>

5、配置framework
- facebook …….需要从Facebook上下载
UMengSDK和UMmengSDK_Extra_Frameworks…….需要从友盟上下载
YKShare
直接把这几个文件拖进项目里面就可以了。


6、调用方法。
   /**
    设置分享的内容
    
    @param ViewController   分享到目的VC
    @param wechatURL    微信点击后进入的网页URL字符串
    @param momentURL    朋友圈点击后进入的网页URL字符串
    @param shareURLString   分享的文章网页URL字符串
    @param content  分享标题显示的文字
    @param imageURLString   图片URL的字符串
    @param defaultImage     若没有图片时，默认的图片
    
    */
   func showCustomShareViewController(ViewController: UIViewController, wechatURL: String?, momentURL: String?, shareURLString: String!, content: String?, imageURLString: String?, defaultImage: UIImage?)
