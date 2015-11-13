
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
      NSLog(@"登录失败");
    }else{
      NSLog(@"登录成功，username:%@,password:%@,userId:%@",user.username,user.password,user.objectId);
      UIViewController *mainViewController = [[UIViewController alloc] init];
      mainViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
      [self presentViewController:mainViewController animated:true completion:^{
        //todo;
      }];
    }
    
  }];
  
}

#pragma mark - 触摸屏幕隐藏键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
  
  [self.usernameTextField resignFirstResponder];
  [self.passwordTextField resignFirstResponder];
  
}

@end










