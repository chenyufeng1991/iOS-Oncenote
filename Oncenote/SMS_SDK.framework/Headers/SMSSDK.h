//
//  SMS_SDK.h
//  SMS_SDKDemo
//
//  Created by 刘 靖煌 on 14-8-28.
//  Copyright (c) 2014年 掌淘科技. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SMSSDKResultHanderDef.h"
#import "SMSSDKUserInfo.h"
#import <MessageUI/MessageUI.h>

/**
 * @brief 核心类（Core class）v1.2.0
 */
@interface SMSSDK : NSObject <MFMessageComposeViewControllerDelegate>

/**
 *  初始化应用，此方法在应用启动时在主线程中调用。(This method is called in the main thread in application:didFinishLaunchingWithOptions: method)
 *
 *  @param appKey    在Mob官网(http://mob.com/ )中注册的应用Key。(The appKey of mob Application. Log in to http://mob.com/ to register to be a Mob developer and create a application if you don't have one)
 *  @param appSecret 在Mob官网(http://mob.com/ )中注册的应用秘钥。(The appSecret of mob Application. Log in to http://mob.com/ to register to be a Mob developer and create a application if you don't have one)
 */
+(void)registerApp:(NSString*)appKey withSecret:(NSString*)appSecret;


#pragma mark - 支持获取验证码和提交验证码 (get the verification code and commit verifacation code)
/**
 *  @from                    v1.1.1
 *  @brief                   获取验证码(Get verification code by SMS)
 *
 *  @param method            获取验证码的方法(The method of getting verificationCode)
 *  @param phoneNumber       电话号码(The phone number)
 *  @param zone              区域号，不要加"+"号(Area code)
 *  @param customIdentifier  自定义短信模板标识 该标识需从官网http://www.mob.com上申请，审核通过后获得。(Custom model of SMS.  The identifier can get it  from http://www.mob.com  when the application had approved)
 *  @param result            请求结果回调(Results of the request)
 */
+(void)getVerificationCodeByMethod:(SMSGetCodeMethod)method
                       phoneNumber:(NSString *)phoneNumber
                              zone:(NSString *)zone
                  customIdentifier:(NSString *)customIdentifier
                            result:(SMSGetCodeResultHandler)result;


/**
 * @from               v1.1.1
 * @brief              提交验证码(Commit the verification code)
 *
 * @param code         验证码(Verification code)
 * @param phoneNumber  电话号码(The phone number)
 * @param zone         区域号，不要加"+"号(Area code)
 * @param result       请求结果回调(Results of the request)
 */
+(void)commitVerificationCode:(NSString *)code
                  phoneNumber:(NSString *)phoneNumber
                         zone:(NSString *)zone
                       result:(SMSCommitCodeResultHandler)result;


@end
