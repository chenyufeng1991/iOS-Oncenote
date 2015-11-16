//
//  SMS_AddressBook.h
//  SMS_SDKDemo
//
//  Created by 掌淘科技 on 14-6-11.
//  Copyright (c) 2014年 掌淘科技. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * @brief SMS_AddressBook类 为通讯录信息
 */
@interface SMSSDKAddressBook : NSObject

/**
 * @brief 姓名
 */
@property(nonatomic,copy) NSString* name;

/**
 * @brief 通讯录id
 */
@property(nonatomic,copy) NSString* recordid;

/**
 * @brief 姓名前缀
 */
@property(nonatomic,copy) NSString* prefixname;

/**
 * @brief 姓名后缀
 */
@property(nonatomic,copy) NSString* suffixname;

/**
 * @brief 最后的姓名
 */
@property(nonatomic,copy) NSString* lastname;

/**
 * @brief 最前的姓名
 */
@property(nonatomic,copy) NSString* firstname;

/**
 * @brief 中间名
 */
@property(nonatomic,copy) NSString* middlename;

/**
 * @brief 昵称
 */
@property(nonatomic,copy) NSString* nickname;

/**
 * @brief 显示的名字
 */
@property(nonatomic,copy) NSString* displayname;

/**
 * @brief 公司
 */
@property(nonatomic,copy) NSString* company;

/**
 * @brief 职位
 */
@property(nonatomic,copy) NSString* position;

/**
 * @brief 电话
 */
@property(nonatomic,copy) NSString* phones;

/**
 * @brief 邮箱
 */
@property(nonatomic,copy) NSString* mails;

/**
 * @brief 地址
 */
@property(nonatomic,copy) NSString* addresses;

/**
 * @brief 特殊日子
 */
@property(nonatomic,copy) NSString* specialdata;

/**
 * @brief ims
 */
@property(nonatomic,copy) NSString* ims;

/**
 * @brief 群组
 */
@property(nonatomic,copy) NSString* group;

/**
 * @brief 备注
 */
@property(nonatomic,copy) NSString* remarks;

/**
 * @brief 个人站点
 */
@property(nonatomic,copy) NSString* websites;

/**
 * @brief 关系
 */
@property(nonatomic,copy) NSString* relations;

/**
 * @brief 其他
 */
@property(nonatomic,copy) NSString* others;

/**
 * @brief 第二个电话
 */
@property(nonatomic,copy) NSString* phone2;

/**
 * @brief 所有电话列表
 */
@property(nonatomic,strong) NSMutableArray* phonesEx;
@end
