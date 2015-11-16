//
//  SMSSDK+ExtexdMethods.h
//  SMS_SDK
//
//  Created by 李愿生 on 15/8/25.
//  Copyright (c) 2015年 掌淘科技. All rights reserved.
//

#import <SMS_SDK/SMSSDK.h>

@interface SMSSDK (ExtexdMethods)

/**
 * @from         v1.1.1
 * @brief        获取区号(Get the Area code of the country)
 *
 * @param result 请求结果回调(Results of the request)
 */
+(void)getCountryZone:(SMSGetZoneResultHandler)result;

/**
 * @from          v1.1.1
 * @brief         提交用户资料(Submit the user information data)
 *
 * @param user    用户信息(User information)
 * @param result  请求结果回调(Results of the request)
 */
+(void)submitUserInfoHandler:(SMSSDKUserInfo*)userInfo
                      result:(SMSSubmitUserInfoResultHandler)result;

@end
