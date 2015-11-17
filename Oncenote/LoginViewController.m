
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
#import "Constant.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property(nonatomic,strong) AppDelegate *globalApp;
@property(nonatomic,strong) NSUserDefaults *userDefaults;

@end

@implementation LoginViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.globalApp = [[UIApplication sharedApplication] delegate];
  self.userDefaults = [NSUserDefaults standardUserDefaults];
  
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
      //登录成功要进行一次查询，查询出该用户的nickname；
      
      BmobQuery *queryNickname = [BmobQuery queryWithClassName:USER_TABLE];
      [queryNickname getObjectInBackgroundWithId:user.objectId block:^(BmobObject *object, NSError *error) {
        if (error) {
          //错误处理；
        }else{
          
          if (object) {
            NSString *nickname = [object objectForKey:@"nickname"];
            NSLog(@"1111111111昵称是：%@",nickname);
            
            [self.userDefaults setObject:nickname forKey:@"nickname"];
            self.globalApp.GLOBAL_NICKNAME = nickname;
            
            
            
            
            //界面跳转；
            UIViewController *mainViewController = [[UIViewController alloc] init];
            mainViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
            [self presentViewController:mainViewController animated:true completion:nil];
          }
        }
      }];
      
      //给全局变量设值；
      self.globalApp.GLOBAL_USERNAME = username;
      self.globalApp.GLOBAL_USERID = user.objectId;
      
      
      //登录成功，同时把用户名密码存储到UserDefault中；
      [self.userDefaults setObject:user.objectId forKey:@"userId"];
      [self.userDefaults setObject:username forKey:@"username"];
      [self.userDefaults setObject:password forKey:@"password"];
      
      
      
    }
  }];
  
}

#pragma mark - 触摸屏幕隐藏键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
  
  [self.usernameTextField resignFirstResponder];
  [self.passwordTextField resignFirstResponder];
  
}

@end










