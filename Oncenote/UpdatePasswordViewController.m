
//
//  UpdatePasswordViewController.m
//  Oncenote
//
//  Created by chenyufeng on 15/11/17.
//  Copyright © 2015年 chenyufengweb. All rights reserved.
//

#import "UpdatePasswordViewController.h"
#import "AllUtils.h"
#import <BmobSDK/Bmob.h>
#import "Constant.h"
#import "AppDelegate.h"

@interface UpdatePasswordViewController ()

@property (weak, nonatomic) IBOutlet UITextField *oldPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *nowPasswordTextField;

@end

@implementation UpdatePasswordViewController

- (void)viewDidLoad {

  [super viewDidLoad];
}

#pragma mark - 所有按钮的点击事件

- (IBAction)naviCancelButtonPressed:(id)sender {
  
  [AllUtils jumpToViewController:@"SettingViewController" contextViewController:self handler:nil];
}

- (IBAction)naviDoneButtonPressed:(id)sender {
  
  AppDelegate *app = [[UIApplication sharedApplication] delegate];
  [self isOldPasswordRight:USER_TABLE userId:app.GLOBAL_USERID oldPassword:self.oldPasswordTextField.text];
}

#pragma mark - 判断原密码是否正确
- (void)isOldPasswordRight:(NSString*)tableName userId:(NSString*)userId oldPassword:(NSString*)oldPassword{
  
  AppDelegate *app = [[UIApplication sharedApplication] delegate];
  BmobQuery *query = [BmobQuery queryWithClassName:USER_TABLE];
  [query getObjectInBackgroundWithId:app.GLOBAL_USERID block:^(BmobObject *object, NSError *error) {
    
    if ([[object objectForKey:@"Password"] isEqualToString:oldPassword]) {
      //原密码正确，可以进行修改
      if ([self.nowPasswordTextField.text isEqualToString:@""]) {

        [AllUtils showPromptDialog:@"提示" andMessage:@"新密码不能为空！" OKButton:@"确定" OKButtonAction:nil cancelButton:@"" cancelButtonAction:nil contextViewController:self];
      }else{
        //正式修改；
        [AllUtils showPromptDialog:@"提示" andMessage:@"修改密码后将重新登录，确认修改吗？" OKButton:@"确定" OKButtonAction:^(UIAlertAction *action) {
          [self updatePassword:USER_TABLE userId:app.GLOBAL_USERID nowPassword:self.nowPasswordTextField.text];
        } cancelButton:@"取消" cancelButtonAction:nil contextViewController:self];
      }
    }else{

      [AllUtils showPromptDialog:@"提示" andMessage:@"您输入的原密码错误，请确认后再修改密码" OKButton:@"确定" OKButtonAction:nil cancelButton:@"" cancelButtonAction:nil contextViewController:self];
    }
  }];
}

#pragma mark - 修改新密码
- (void)updatePassword:(NSString*)tableName userId:(NSString*)userId nowPassword:(NSString*)nowPassword{
  
  BmobQuery *update = [BmobQuery queryWithClassName:tableName];
  [update getObjectInBackgroundWithId:userId block:^(BmobObject *object, NSError *error) {
    if (!error) {
      if (object) {

        [object setObject:nowPassword forKey:@"Password"];
        [object updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
          if (isSuccessful) {
            //跳转到登录界面；
            [AllUtils jumpToViewController:@"LoginViewController" contextViewController:self handler:nil];
          } else {

            [AllUtils showPromptDialog:@"提示" andMessage:@"网络异常，修改密码失败！" OKButton:@"确定" OKButtonAction:nil cancelButton:@"" cancelButtonAction:nil contextViewController:self];
            NSLog(@"错误信息2：%@",error);
          }
        }];
      }
    }else{

      NSLog(@"错误信息1：%@",error);
    }
  }];
}

@end
