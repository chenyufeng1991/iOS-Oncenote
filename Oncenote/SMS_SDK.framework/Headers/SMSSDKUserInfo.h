//
//  UserInfo.h
//  SMS_SDKDemo
//
//  Created by 掌淘科技 on 14-6-19.
//  Copyright (c) 2014年 掌淘科技. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * @brief SMS_UserInfo 用户信息
 */
@interface SMSSDKUserInfo : NSObject

/**
 * @brief 用户头像地址
 */
@property(nonatomic,copy) NSString* avatar;

/**
 * @brief 用户id 用户自行定义
 */
@property(nonatomic,copy) NSString* uid;

/**
 * @brief 用户名
 */
@property(nonatomic,copy) NSString* nickname;

/**
 * @brief 电话
 */
@property(nonatomic,copy) NSString* phone;

@end
