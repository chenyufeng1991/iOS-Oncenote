//
//  SMSSDK+AddressBookMethods.h
//  SMS_SDK
//
//  Created by 李愿生 on 15/8/25.
//  Copyright (c) 2015年 掌淘科技. All rights reserved.
//

#import <SMS_SDK/SMSSDK.h>

@interface SMSSDK (AddressBookMethods)


#pragma mark - 是否启用通讯录好友功能、提交用户资料、请求通讯好友信息
/**
 * @brief          是否允许访问通讯录好友(is Allowed to access to address book)
 
 * @param  state   YES 代表启用 NO 代表不启用 默认为启用(YES,by default,means allow to access to address book)
 */
+(void)enableAppContactFriends:(BOOL)state;


/**
 * @from          v1.1.1
 * @brief         向服务端请求获取通讯录好友信息(Get the data of address book which save in the server)
 *
 * @param  choose 调用参数 默认值为1(Get the chosen friend data of address book,the default value is 1)
 * @param  result 请求结果回调(Results of the request)
 */
+(void)getAllContactFriends:(int)choose
                     result:(SMSGetAllContactFriendsResultHandler)result;


#pragma mark - 设置最新好友条数、显示最新好友条数
/**
 * @brief         设置新增好友条数(The new added friends)
 *
 * @param count   好友条数(The number of friends)
 */
+(void)setLatelyFriendsCount:(int)count;

/**
 * @brief         显示新增好友条数回调(Display recently new friends number callback)
 *
 * @param result  结果回调(Results of the request )
 */
+(void)showFriendsBadge:(SMSShowNewFriendsCountBlock)result;

@end
