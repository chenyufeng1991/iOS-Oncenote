
//
//  LaunchScreenViewController.m
//  Oncenote
//
//  Created by chenyufeng on 15/11/15.
//  Copyright © 2015年 chenyufengweb. All rights reserved.
//

#import "LaunchScreenViewController.h"
#import "AppDelegate.h"
#import "AllUtils.h"

@interface LaunchScreenViewController ()

@end

@implementation LaunchScreenViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
}


- (void)viewDidAppear:(BOOL)animated{
  
  [super viewDidAppear:animated];
  NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
  
  
  if ([userDefaults objectForKey:@"guidepage"] == nil) {
    //如果这个首选项为空的话，表示用户是刚刚安装App，所以要显示引导页；
    //直接跳到引导页；
    [AllUtils jumpToViewController:@"GuidePageViewController" contextViewController:self handler:nil];
  }else{
    
    //不是第一次安装；
    if ([userDefaults objectForKey:@"username"] != nil && [userDefaults objectForKey:@"Password"] != nil ) {
      //存储了用户名密码，直接跳到主界面；
      NSLog(@"直接跳到主界面");
      
      AppDelegate *globalApp = [[UIApplication sharedApplication] delegate];
      globalApp.GLOBAL_USERNAME = [userDefaults objectForKey:@"username"];
      globalApp.GLOBAL_USERID = [userDefaults objectForKey:@"userId"];
      globalApp.GLOBAL_NICKNAME = [userDefaults objectForKey:@"nickname"];
      globalApp.GLOBAL_PASSWORD = [userDefaults objectForKey:@"Password"];
      
      [AllUtils jumpToViewController:@"MainViewController" contextViewController:self handler:nil];
      
    }else{
      NSLog(@"跳到登录界面");
      //跳到登录界面；
      [AllUtils jumpToViewController:@"LoginViewController" contextViewController:self handler:nil];
      
    }
    
  }
  
  
  
  
  
  
}


@end







