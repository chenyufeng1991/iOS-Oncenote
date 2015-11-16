//
//  CountryAndAreaCode.h
//  SMS_SDKDemo
//
//  Created by 掌淘科技 on 14-6-6.
//  Copyright (c) 2014年 掌淘科技. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * @brief 国家名称和国家码类
 */
@interface SMSSDKCountryAndAreaCode : NSObject

/**
 * @brief 国家中文名称
 */
@property(nonatomic,copy) NSString* countryName;

/**
 * @brief 国家码
 */
@property(nonatomic,copy) NSString* areaCode;

/**
 * @brief 国家拼音名字
 */
@property(nonatomic,copy) NSString* pinyinName;

@end
