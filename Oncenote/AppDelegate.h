//
//  AppDelegate.h
//  Oncenote
//
//  Created by chenyufeng on 15/11/12.
//  Copyright © 2015年 chenyufengweb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong,nonatomic) NSString *GLOBAL_USERID;//全局的objectID;当前的用户ID；
@property (strong,nonatomic) NSString *GLOBAL_USERNAME;//全局的用户名,也就是手机号；
@property (strong,nonatomic) NSString *GLOBAL_NICKNAME;//全局的昵称；
@property (strong,nonatomic) NSString *GLOBAL_PASSWORD;//全局的密码；

//尝试全局使用一个笔记数组；
@end

