//
//  SettingViewController.m
//  Oncenote
//
//  Created by chenyufeng on 15/11/17.
//  Copyright © 2015年 chenyufengweb. All rights reserved.
//

#import "SettingViewController.h"
#import "MainViewController.h"
#import "LoginViewController.h"
#import "AllUtils.h"

@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *settingTableView;





@end

@implementation SettingViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  
  return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
  return nil;
}


#pragma mark - 所有按钮的点击操作

- (IBAction)naviCloseButtonPressed:(id)sender {
  
  UIViewController *mainViewController = [[UIViewController alloc] init];
  mainViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
  [self presentViewController:mainViewController animated:true completion:nil];
  
  
}

//退出登录按钮
- (IBAction)naviLogoutButtonPressed:(id)sender {
  
  
  [AllUtils showPromptDialog:@"提示" andMessage:@"你真的要退出朝夕笔记吗？" OKButton:@"确定" OKButtonAction:^(UIAlertAction *action) {
    
    //把用户名和密码设为nil；
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:nil forKey:@"username"];
    [userDefaults setObject:nil forKey:@"password"];
    
    //同时跳转到登录界面；
    UIViewController *loginViewController = [[UIViewController alloc] init];
    loginViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    [self presentViewController:loginViewController animated:true completion:nil];
    
    
  } cancelButton:@"取消" cancelButtonAction:^(UIAlertAction *action) {
    
  } contextViewController:self];
  
  
  
  
  
  
  
  
  
  
  
  
  
}



@end
