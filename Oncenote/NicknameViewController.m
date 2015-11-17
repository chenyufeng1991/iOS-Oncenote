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
  
  UIViewController *settingViewController = [[UIViewController alloc] init];
  settingViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SettingViewController"];
  [self presentViewController:settingViewController animated:true completion:nil];
  
}

- (IBAction)naviDoneButtonPressed:(id)sender {
  
  AppDelegate *app = [[UIApplication  sharedApplication] delegate];
  app.GLOBAL_NICKNAME = self.nicknameTextField.text;
  
  //同时也要把这个昵称存到NSUSerDefaults；
  NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
  [userDefaults setObject:self.nicknameTextField.text forKey:@"nickname"];
  
  //把昵称插入到指定UserID的数据库中；
  [BmobOperation updateNicknameToUserTable:USER_TABLE userId:app.GLOBAL_USERID nickname:self.nicknameTextField.text];
  
  
  [AllUtils showPromptDialog:@"提示" andMessage:@"修改昵称成功" OKButton:@"确定" OKButtonAction:^(UIAlertAction *action) {
    UIViewController *settingViewController = [[UIViewController alloc] init];
    settingViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SettingViewController"];
    [self presentViewController:settingViewController animated:true completion:nil];
    
  } cancelButton:@"" cancelButtonAction:nil contextViewController:self];
  
}



@end
