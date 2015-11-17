
//
//  LoginViewController.m
//  Oncenote
//
//  Created by chenyufeng on 15/11/13.
//  Copyright © 2015年 chenyufengweb. All rights reserved.
//

#import "LoginViewController.h"
#import "MainViewController.h"
#import <BmobSDK/Bmob.h>
#import "AppDelegate.h"
#import "AllUtils.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
}

#pragma mark - 所有的按钮点击；
- (IBAction)loginButtonPressed:(id)sender {
  NSString *username = [self.usernameTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
  NSString *password = [self.passwordTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
  
  [BmobUser loginWithUsernameInBackground:username password:password block:^(BmobUser *user, NSError *error) {
    if (error) {
      //错误处理
      [AllUtils showPromptDialog:@"提示" andMessage:@"登录失败，请输入正确的手机号和密码" OKButton:@"确定" OKButtonAction:nil cancelButton:@"" cancelButtonAction:nil contextViewController:self];
      
    }else{
      
      //给全局变量设值；
      AppDelegate *globalApp = [[UIApplication sharedApplication] delegate];
      globalApp.GLOBAL_USERNAME = username;
      globalApp.GLOBAL_USERID = user.objectId;
      
      
      //登录成功，同时把用户名密码存储到UserDefault中；
      NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
      [userDefaults setObject:user.objectId forKey:@"userId"];
      [userDefaults setObject:username forKey:@"username"];
      [userDefaults setObject:password forKey:@"password"];
      
      
      //      NSLog(@"登录成功，username:%@,password:%@,userId:%@",user.username,user.password,user.objectId);
      UIViewController *mainViewController = [[UIViewController alloc] init];
      mainViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
      [self presentViewController:mainViewController animated:true completion:nil];
      
    }
  }];
  
}

#pragma mark - 触摸屏幕隐藏键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
  
  [self.usernameTextField resignFirstResponder];
  [self.passwordTextField resignFirstResponder];
  
}

@end










