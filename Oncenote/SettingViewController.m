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
#import "SettingList.h"
#import "NicknameViewController.h"

@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *settingTableView;

@property(nonatomic,strong) SettingList *settingList;
@property(nonatomic,strong) NSArray *listArray;

@end

@implementation SettingViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  
  self.settingList = [[SettingList alloc] init];
  self.listArray = self.settingList.settingListArray;
  
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  
  return [self.listArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SettingCell" forIndexPath:indexPath];
  cell.textLabel.text = [self.listArray objectAtIndex:indexPath.row];
  
  return cell;
  
}


#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

  switch (indexPath.row) {
    case 0:{
    
      UIViewController *nicknameViewController = [[UIViewController alloc] init];
      nicknameViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"NicknameViewController"];
      [self presentViewController:nicknameViewController animated:true completion:nil];
    }
      break;
      
    default:
      break;
  }
  
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
