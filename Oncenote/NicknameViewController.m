//
//  NicknameViewController.m
//  Oncenote
//
//  Created by chenyufeng on 15/11/17.
//  Copyright © 2015年 chenyufengweb. All rights reserved.
//

#import "NicknameViewController.h"
#import "SettingViewController.h"
#import "BmobOperation.h"
#import "Constant.h"
#import "AppDelegate.h"
#import "AllUtils.h"
#import <BmobSDK/Bmob.h>

@interface NicknameViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nicknameTextField;

@end

@implementation NicknameViewController

- (void)viewDidLoad {

  [super viewDidLoad];
  AppDelegate *app = [[UIApplication sharedApplication] delegate];
  if (app.GLOBAL_NICKNAME == nil || [app.GLOBAL_NICKNAME isEqualToString:@""]) {

    self.nicknameTextField.text = @"";
  }else{

    self.nicknameTextField.text = app.GLOBAL_NICKNAME;
  }
}

- (IBAction)naviCancelButtonPressed:(id)sender {

  [AllUtils jumpToViewController:@"SettingViewController" contextViewController:self handler:nil];
}

- (IBAction)naviDoneButtonPressed:(id)sender {
  
  AppDelegate *app = [[UIApplication  sharedApplication] delegate];
  //把昵称插入到指定UserID的数据库中；
  //  [BmobOperation updateNicknameToUserTable:USER_TABLE userId:app.GLOBAL_USERID nickname:self.nicknameTextField.text];
  BmobQuery *update = [BmobQuery queryWithClassName:USER_TABLE];
  [update getObjectInBackgroundWithId:app.GLOBAL_USERID block:^(BmobObject *object,NSError *error){
    if (!error) {
      if (object) {

        [object setObject:self.nicknameTextField.text forKey:@"nickname"];
        [object updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
          
          if (isSuccessful) {

            app.GLOBAL_NICKNAME = self.nicknameTextField.text;
            //同时也要把这个昵称存到NSUSerDefaults；
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:self.nicknameTextField.text forKey:@"nickname"];
            [AllUtils showPromptDialog:@"提示" andMessage:@"修改昵称成功" OKButton:@"确定" OKButtonAction:^(UIAlertAction *action) {

              [AllUtils jumpToViewController:@"SettingViewController" contextViewController:self handler:nil];
            } cancelButton:@"" cancelButtonAction:nil contextViewController:self];
            
          } else {

            [AllUtils showPromptDialog:@"提示" andMessage:@"网络异常，修改昵称失败，请稍候再试！" OKButton:@"确定" OKButtonAction:nil cancelButton:@"" cancelButtonAction:nil contextViewController:self];
            NSLog(@"昵称错误信息：%@",error);
          }
        }];
      }
    }else{
      //进行错误处理
    }
  }];
}

@end
