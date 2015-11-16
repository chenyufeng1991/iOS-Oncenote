//
//  RegisterViewController.m
//  Oncenote
//
//  Created by chenyufeng on 15/11/13.
//  Copyright © 2015年 chenyufengweb. All rights reserved.
//

#import "RegisterViewController.h"
#import <BmobSDK/Bmob.h>
#import "AllUtils.h"

@interface RegisterViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
}

#pragma mark - 所有按钮的点击操作；
- (IBAction)createAccountButtonPressed:(id)sender {
  NSString *username = [self.usernameTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
  NSString *password = [self.passwordTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
  
  if (![username  isEqual: @""] && ![password  isEqual: @""]) {
    //用户名密码同时不为空，才可以进行注册；
    BmobUser *user = [[BmobUser alloc]init];
    [user setUsername:username];
    [user setPassword:password];
    [user signUpInBackgroundWithBlock:^(BOOL isSuccessful, NSError *error) {
      if (isSuccessful) {
        [AllUtils showPromptDialog:@"提示" andMessage:@"注册成功，请登录！" OKButton:@"确定" OKButtonAction:^(UIAlertAction *action) {
          NSLog(@"注册成功");
        } cancelButton:@"" cancelButtonAction:nil contextViewController:self];
        
      }else{
        [AllUtils showPromptDialog:@"提示" andMessage:@"服务器异常，注册失败！" OKButton:@"确定" OKButtonAction:^(UIAlertAction *action) {
          NSLog(@"注册失败");
        } cancelButton:@"" cancelButtonAction:nil contextViewController:self];
      }
    }];
  }else{
    [AllUtils showPromptDialog:@"提示" andMessage:@"请填写完整信息！" OKButton:@"确定" OKButtonAction:^(UIAlertAction *action) {
      NSLog(@"请输入信息");
    } cancelButton:@"" cancelButtonAction:nil contextViewController:self];
  }
}

#pragma mark - 触摸屏幕隐藏键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
  
  [self.usernameTextField resignFirstResponder];
  [self.passwordTextField resignFirstResponder];
  
}

@end
