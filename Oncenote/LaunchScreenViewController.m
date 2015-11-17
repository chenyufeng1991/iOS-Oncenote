
//
//  LaunchScreenViewController.m
//  Oncenote
//
//  Created by chenyufeng on 15/11/15.
//  Copyright © 2015年 chenyufengweb. All rights reserved.
//

#import "LaunchScreenViewController.h"
#import "AppDelegate.h"

@interface LaunchScreenViewController ()

@end

@implementation LaunchScreenViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  

  
}


- (void)viewDidAppear:(BOOL)animated{

  [super viewDidAppear:animated];
  NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
  
  if ([userDefaults objectForKey:@"username"] != nil && [userDefaults objectForKey:@"password"] != nil ) {
    //直接跳到主界面；
    NSLog(@"直接跳到主界面");
    
    AppDelegate *globalApp = [[UIApplication sharedApplication] delegate];
    globalApp.GLOBAL_USERNAME = [userDefaults objectForKey:@"username"];
    globalApp.GLOBAL_USERID = [userDefaults objectForKey:@"userId"];
    globalApp.GLOBAL_NICKNAME = [userDefaults objectForKey:@"nickname"];
    
    
    UIViewController *mainViewController = [[UIViewController alloc] init];
    mainViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
    [self presentViewController:mainViewController animated:true completion:nil];
    
    
  }else{
    NSLog(@"跳到登录界面");
    //跳到登录界面；
    UIViewController *loginViewController = [[UIViewController alloc] init];
    loginViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    [self presentViewController:loginViewController animated:true completion:nil];
    
    
  }
}


@end







