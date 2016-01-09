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
#import "LoginViewController.h"
#import "Constant.h"
//15626266152
//18285115452
#import <SMS_SDK/SMSSDK.h>
#import <SMS_SDK/SMSSDKCountryAndAreaCode.h>
#import <SMS_SDK/SMSSDK+DeprecatedMethods.h>
#import <SMS_SDK/SMSSDK+ExtexdMethods.h>
#import <MOBFoundation/MOBFoundation.h>

@interface RegisterViewController ()

//这里的用户名也就是手机号；
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *validateCodeTextField;

@end

@implementation RegisterViewController

- (void)viewDidLoad {

  [super viewDidLoad];
}

#pragma mark - 所有按钮的点击操作；
//创建账号；
//重写注册的方法，不使用默认的_User表，而使用自己建的User表；
- (IBAction)createAccountButtonPressed2:(id)sender{
  
  //首先判断有没有验证成功；
  [SMSSDK commitVerificationCode:self.validateCodeTextField.text phoneNumber:self.usernameTextField.text zone:@"86" result:^(NSError *error) {
    
    if (!error) {

      NSString *username = [self.usernameTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
      NSString *password = [self.passwordTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
      if (![username  isEqual: @""] && ![password  isEqual: @""]) {
        //用户名密码同时不为空，才可以进行注册；
        //向User表中插入一条用户信息；
        BmobObject *createAccount = [BmobObject objectWithClassName:USER_TABLE];
        [createAccount setObject:username forKey:@"username"];
        [createAccount setObject:password forKey:@"Password"];
        [createAccount saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
          
          if (isSuccessful) {
            
            [AllUtils showPromptDialog:@"提示" andMessage:@"注册成功，请登录！" OKButton:@"确定" OKButtonAction:^(UIAlertAction *action) {
              
              [AllUtils jumpToViewController:@"LoginViewController" contextViewController:self handler:nil];
            } cancelButton:@"" cancelButtonAction:nil contextViewController:self];
          } else {

            [AllUtils showPromptDialog:@"提示" andMessage:@"服务器异常，注册失败，请稍候再试！" OKButton:@"确定" OKButtonAction:nil cancelButton:@"" cancelButtonAction:nil contextViewController:self];
          }
        }];
      }else{

        [AllUtils showPromptDialog:@"提示" andMessage:@"请填写完整信息！" OKButton:@"确定" OKButtonAction:nil cancelButton:@"" cancelButtonAction:nil contextViewController:self];
      }
    }//if();
    else{

      [AllUtils showPromptDialog:@"提示" andMessage:@"验证失败，请重新获取验证码！" OKButton:@"确定" OKButtonAction:nil cancelButton:@"" cancelButtonAction:nil contextViewController:self];
    }
  }];
}

//获取验证码；
- (IBAction)getValidateCodeButtonPressed:(id)sender {
  //应该在这里对该手机号进行数据库查询，不能重复进行同一个手机号的注册。
  //如果该手机号已经存在，不能获取验证码。
  //注意：还应该加一个昵称；
  [self isRepeatUsername:USER_TABLE username:self.usernameTextField.text limitCount:50];
}

- (IBAction)loginButtonPressed:(id)sender {

  [AllUtils jumpToViewController:@"LoginViewController" contextViewController:self handler:nil];
}

#pragma mark - 查询该手机号是否已经注册
- (void)isRepeatUsername:(NSString*)tableName username:(NSString*)username limitCount:(int)limitCount{
  
  __block BOOL isRepeatUsername = false;
  BmobQuery *queryUser = [BmobQuery queryWithClassName:tableName];
  queryUser.limit = limitCount;
  [queryUser findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
    
    if (!error) {
      for (BmobObject *obj in array) {
        if ([(NSString*)[obj objectForKey:@"username"] isEqualToString:username]) {
          //表示已经存在该用户名；
          isRepeatUsername = true;
          break;
        }
      }
    } else {

      [AllUtils showPromptDialog:@"提示" andMessage:@"网络异常，请稍候重试！" OKButton:@"确定" OKButtonAction:nil cancelButton:@"" cancelButtonAction:nil contextViewController:self];
    }
    if (isRepeatUsername) {

      [AllUtils showPromptDialog:@"提示" andMessage:@"该账户已经存在，请直接登录！" OKButton:@"确定" OKButtonAction:nil cancelButton:@"" cancelButtonAction:nil contextViewController:self];
    }else{
      //该手机号没有注册，可以获取验证码；
      [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.usernameTextField.text
                                     zone:@"86"
                         customIdentifier:nil
                                   result:^(NSError *error){
                                     if (!error){
                                       [AllUtils showPromptDialog:@"提示" andMessage:@"验证码发送成功，请稍候！" OKButton:@"确定" OKButtonAction:nil cancelButton:@"" cancelButtonAction:nil contextViewController:self];
                                     }
                                     else{
                                       [AllUtils showPromptDialog:@"提示" andMessage:@"手机号格式错误，请输入正确的手机号！" OKButton:@"确定" OKButtonAction:nil cancelButton:@"" cancelButtonAction:nil contextViewController:self];
                                     }
                                   }];
    }
  }];
}

#pragma mark - 触摸屏幕隐藏键盘
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
  
  [self.usernameTextField resignFirstResponder];
  [self.passwordTextField resignFirstResponder];
  [self.validateCodeTextField resignFirstResponder];
}

@end
