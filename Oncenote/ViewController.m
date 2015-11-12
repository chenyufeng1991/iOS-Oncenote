//
//  ViewController.m
//  Oncenote
//
//  Created by chenyufeng on 15/11/12.
//  Copyright © 2015年 chenyufengweb. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self setNavigationBarItemButton];
  
  
}

#pragma mark - 设置导航栏的按钮
- (void)setNavigationBarItemButton{
  //设置左侧“设置”按钮；
  UIButton *naviSettingButton  = [UIButton buttonWithType:UIButtonTypeCustom];
  [naviSettingButton setBackgroundImage:[UIImage imageNamed:@"navi_setting.png"] forState:UIControlStateNormal];
  [naviSettingButton addTarget:self action:@selector(naviSettingButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
  naviSettingButton.frame = CGRectMake(0, 0, 30, 30);
  UIBarButtonItem *naviSetting = [[UIBarButtonItem alloc] initWithCustomView:naviSettingButton];
  self.navigationItem.leftBarButtonItem = naviSetting;

  //设置右侧“刷新”，“查找”按钮；
  UIButton *naviRefreshButton  = [UIButton buttonWithType:UIButtonTypeCustom];
  [naviRefreshButton setBackgroundImage:[UIImage imageNamed:@"navi_refresh.png"] forState:UIControlStateNormal];
  [naviRefreshButton addTarget:self action:@selector(naviRefreshButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
  naviRefreshButton.frame = CGRectMake(0, 0, 30, 30);
  UIBarButtonItem *naviRefresh  = [[UIBarButtonItem alloc] initWithCustomView:naviRefreshButton];
  
  UIButton *naviSearchButton  = [UIButton buttonWithType:UIButtonTypeCustom];
  [naviSearchButton setBackgroundImage:[UIImage imageNamed:@"navi_search.png"] forState:UIControlStateNormal];
  [naviSearchButton addTarget:self action:@selector(naviSearchButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
  naviSearchButton.frame = CGRectMake(0, 0, 30, 30);
  UIBarButtonItem *naviSearch  = [[UIBarButtonItem alloc] initWithCustomView:naviSearchButton];
  
  NSArray *itemButtonArray = [[NSArray alloc] initWithObjects:naviSearch,naviRefresh, nil];
  self.navigationItem.rightBarButtonItems = itemButtonArray;
  
}



#pragma mark - 所有的按钮点击事件
//点击导航栏左侧的设置按钮；
- (void)naviSettingButtonPressed:(id)sender{
  UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"这是设置按钮" preferredStyle:  UIAlertControllerStyleAlert];
  [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    //点击按钮的响应事件；
  }]];
  
  [self presentViewController:alert animated:true completion:nil];
}

- (void)naviRefreshButtonPressed:(id)sender{
  UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"这是刷新按钮" preferredStyle:  UIAlertControllerStyleAlert];
  [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    //点击按钮的响应事件；
  }]];
  
  [self presentViewController:alert animated:true completion:nil];
  
}

- (void)naviSearchButtonPressed:(id)sender{
  UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"这是查找按钮" preferredStyle:  UIAlertControllerStyleAlert];
  [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    //点击按钮的响应事件；
  }]];
  
  [self presentViewController:alert animated:true completion:nil];
  
}
@end















