//
//  AppDelegate.m
//  Oncenote
//
//  Created by chenyufeng on 15/11/12.
//  Copyright © 2015年 chenyufengweb. All rights reserved.
//

#import "AppDelegate.h"
#import <BmobSDK/Bmob.h>
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
//微信SDK头文件
#import "WXApi.h"
//新浪微博SDK头文件
#import "WeiboSDK.h"
//新浪微博SDK需要在项目Build Settings中的Other Linker Flags添加"-ObjC"
#import <SMS_SDK/SMSSDK.h>
#import <SMS_SDK/SMSSDK+AddressBookMethods.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  
  //初始化BmobSDK；
  [Bmob registerWithAppKey:@"399fd662392b0852cb22181e40e7b72e"];
  /**
   *  设置ShareSDK的appKey，如果尚未在ShareSDK官网注册过App，请移步到http://mob.com/login 登录后台进行应用注册，
   *  在将生成的AppKey传入到此方法中。
   *  方法中的第二个第三个参数为需要连接社交平台SDK时触发，
   *  在此事件中写入连接代码。第四个参数则为配置本地社交平台时触发，根据返回的平台类型来配置平台信息。
   *  如果您使用的时服务端托管平台信息时，第二、四项参数可以传入nil，第三项参数则根据服务端托管平台来决定要连接的社交SDK。
   */
  [ShareSDK registerApp:@"c5435c5a0d38"
   
        activePlatforms:@[
                          @(SSDKPlatformTypeSinaWeibo),
                          @(SSDKPlatformTypeMail),
                          @(SSDKPlatformTypeSMS),
                          @(SSDKPlatformTypeCopy),
                          @(SSDKPlatformTypeWechat),
                          @(SSDKPlatformTypeQQ)]
               onImport:^(SSDKPlatformType platformType)
   {
     switch (platformType)
     {
       case SSDKPlatformTypeWechat:
         [ShareSDKConnector connectWeChat:[WXApi class]];
         break;
       case SSDKPlatformTypeQQ:
         [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
         break;
       case SSDKPlatformTypeSinaWeibo:
         [ShareSDKConnector connectWeibo:[WeiboSDK class]];
         break;
       default:
         break;
     }
   }
        onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
   {
     
     switch (platformType)
     {
       case SSDKPlatformTypeSinaWeibo:
         //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
         [appInfo SSDKSetupSinaWeiboByAppKey:@"568898243"
                                   appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3"
                                 redirectUri:@"http://www.sharesdk.cn"
                                    authType:SSDKAuthTypeBoth];
         break;
       case SSDKPlatformTypeWechat:
         [appInfo SSDKSetupWeChatByAppId:@"wxa7be3ef36352dc5c"
                               appSecret:@"d4624c36b6795d1d99dcf0547af5443d"];
         break;
       case SSDKPlatformTypeQQ:
         [appInfo SSDKSetupQQByAppId:@"1104897411"
                              appKey:@"BPquMGokMcNp4SOx"
                            authType:SSDKAuthTypeBoth];
         break;
         
       default:
         break;
     }
   }];
  [SMSSDK registerApp:@"c5b27554cac0" withSecret:@"e5b73794486527c6af5b82b5bb450300"];
  return YES;
}

@end
