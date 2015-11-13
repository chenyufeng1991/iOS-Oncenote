//
//  RegisterViewController.m
//  Oncenote
//
//  Created by chenyufeng on 15/11/13.
//  Copyright © 2015年 chenyufengweb. All rights reserved.
//

#import "RegisterViewController.h"
#import "BmobOperation.h"

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
    BmobOperation *addUser = [[BmobOperation alloc] init];
    [addUser addUserToUserTable:@"_User" username:username password:password todo:^(BOOL isSuccessful, NSError *error) {
      //todo;
      if (isSuccessful) {
        [self showPromptDialog:@"提示" andMessage:@"创建账户成功，请登录！" andButton:@"确定" andAction:^(UIAlertAction *action) {
          
        }];
      } else {
        NSLog(@"注册失败：%@",error);
      }
    }];
    
  }else{
    [self showPromptDialog:@"提示" andMessage:@"用户名密码不能为空！" andButton:@"确定" andAction:^(UIAlertAction *action) {
      
    }];
  }
  
}

#pragma mark - 触摸屏幕隐藏键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
  
  [self.usernameTextField resignFirstResponder];
  [self.passwordTextField resignFirstResponder];
  
}

#pragma mark - 弹出提示对话框
- (void)showPromptDialog:(NSString*)title andMessage:(NSString*)message andButton:(NSString*)buttonTitle andAction:(void (^ __nullable)(UIAlertAction *action)) handler{
  
  //尝试使用新的弹出对话框；
  UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
  [alertController addAction:[UIAlertAction actionWithTitle:buttonTitle style:UIAlertActionStyleDefault handler:handler]];
  //弹出提示框；
  [self presentViewController:alertController animated:true completion:nil];
}

@end
