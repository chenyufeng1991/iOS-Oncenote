//
//  SMS_SDK+DeprecatedMethods.h
//  SMS_SDK
//
//  Created by 李愿生 on 15/7/24.
//  Copyright (c) 2015年 掌淘科技. All rights reserved.
//

#import <SMS_SDK/SMSSDK.h>

@interface SMSSDK (DeprecatedMethods)

#pragma mark - 不再建议使用（deprecated）


#pragma mark - 获取appKey、appSecret、addressBook

/**
 * @brief        获取appKey(Get the appKey)
 */
+(NSString*)appKey __deprecated;

/**
 * @brief        获取appSecret(Get the appSecret)
 */
+(NSString*)appSecret __deprecated;

/**
 * @brief        获取通讯录数据(Get the addressBook list data)
 * @return       通讯录数据数组，数据元素类型是SMS_AddressBook(The array of addressBook list data, the type of array's element is SMS_AddressBook)
 */
+(NSMutableArray*)addressBook __deprecated;


#pragma mark - 发送短信
/**
 * @brief               发送短信(Send text messages)
 *
 * @param  phoneNumber  号码(the phone number)
 * @param  msg          短信内容(the content of the message)
 */
+(void)sendSMS:(NSString*)phoneNumber AndMessage:(NSString*)msg __deprecated;

/**
 *  @brief 获取验证码(带短信自定义标识符)(Get verification code by SMS with customIdentifier)
 *
 *  @deprecated 可以使用 +(void)getVerificationCodeByMethod: phoneNumber:zone:customIdentifier:result:替代
 (Deprecated in SMS_SDK v1.1.1  Use +(void)getVerificationCodeByMethod: phoneNumber:zone:customIdentifier:result: instead.)
 *  @from  1.0.9
 *  @param phoneNumber       电话号码(The phone number)
 *  @param zone              区域号，不要加"+"号(Area code)
 *  @param customIdentifier  自定义短信模板标识 该标识需从官网http://www.mob.com上申请，审核通过后获得。(Custom model of SMS.  The identifier can get it  from http://www.mob.com  when the application had approved)
 *  @param result            请求结果回调(Results of the request)
 */
+ (void)getVerificationCodeBySMSWithPhone:(NSString *)phoneNumber
                                     zone:(NSString *)zone
                         customIdentifier:(NSString *)customIdentifier
                                   result:(SMSGetCodeResultHandler)result __deprecated;

/**
 *  @brief 获取验证码(不带短信标识符)(Get verification code by SMS without customIdentifier)
 *
 *  @deprecated 可以使用 +(void)getVerificationCodeByMethod: phoneNumber:zone:customIdentifier:result:替代
 (Deprecated in SMS_SDK v1.1.1  Use +(void)getVerificationCodeByMethod: phoneNumber:zone:customIdentifier:result: instead.)
 *  @param phoneNumber 电话号码(The phone number)
 *  @param zone        区域号，不要加"+"号(Area code)
 *  @param result      请求结果回调(Results of the request)
 */
+ (void)getVerificationCodeBySMSWithPhone:(NSString *)phoneNumber
                                     zone:(NSString *)zone
                                   result:(SMSGetCodeResultHandler)result __deprecated;

/**
 *  @brief 通过语音电话获取语音验证码（Get verification code via voice call）
 *
 *  @deprecated 可以使用 +(void)getVerificationCodeByMethod: phoneNumber:zone:customIdentifier:result:替代
 (Deprecated in SMS_SDK v1.1.1  Use +(void)getVerificationCodeByMethod: phoneNumber:zone:customIdentifier:result: instead.)
 *  @param phone  电话号码(The phone number)
 *  @param zone   区域号，不要加"+"号(Area code)
 *  @param result 请求结果回调(Results of the request)
 */
+ (void)getVerificationCodeByVoiceCallWithPhone:(NSString *)phoneNumber
                                           zone:(NSString *)zone
                                         result:(SMSGetCodeResultHandler)result __deprecated;

/**
 * @brief 提交验证码(Commit the verification code)
 *
 * @deprecated 可以使用 +(void)commitVerificationCode:phoneNumber:zone:result:替代;
 (Deprecated in SMS_SDK v1.1.1 Use +(void)commitVerificationCode:phoneNumber:zone:result: instead.)
 * @param 验证码(Verification code)
 * @param 请求结果回调(Results of the request)
 */
+(void)commitVerifyCode:(NSString *)code
                 result:(SMSCommitVerifyCodeBlock)result __deprecated;

/**
 * @brief 获取区号(Get the Area code of the country)
 *
 * @deprecated 可以使用 +(void)getCountryZone:替代
 (Deprecated in SMS_SDK v1.1.1 Use +(void)getCountryZone: instead)
 * @param result 请求结果回调(Results of the request)
 */
+(void)getZone:(SMSGetZoneBlock)result __deprecated;

/**
 * @brief 提交用户资料(Submit the user information data)
 *
 * @deprecated  可以使用 +(void)submitUserInfoHandler:result: 替代
 (Deprecated in SMS_SDK v1.1.1 Use +(void)submitUserInfoHandler:result: instead.)
 * @param user    用户信息(User information)
 * @param result  请求结果回调(Results of the request)
 */
+(void)submitUserInfo:(SMSSDKUserInfo*)user
               result:(SMSSubmitUserInfoBlock)result __deprecated;

/**
 * @brief 向服务端请求获取通讯录好友信息(Get the data of address book which save in the server)
 *
 * @deprecated 可以使用 +(void)getAllContactFriends:result: 替换;
 (Decrepated in SMS_SDK v1.1.1 Use +(void)getAllContactFriends:result: instead.)
 * @param  choose 调用参数 默认值为1(Get the chosen friend data of address book,the default value is 1)
 * @param  result 请求结果回调(Results of the request)
 */
+(void)getAppContactFriends:(int)choose
                     result:(SMSGetAppContactFriendsBlock)result __deprecated;



@end
