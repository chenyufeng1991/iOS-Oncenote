//
//  ViewController.m
//  Oncenote
//
//  Created by chenyufeng on 15/11/12.
//  Copyright © 2015年 chenyufengweb. All rights reserved.
//


/*
 界面的背景灰色：[UIColor colorWithRed:0.89 green:0.89 blue:0.89 alpha:1]
 主色调绿色：[UIColor colorWithRed:0 green:0.6 blue:0.26 alpha:1]
 
 
 */

#import "ViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *noteTableView;//“笔记”的TableView


@property(nonatomic,strong) NSArray *noteArray;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self setNavigationBarItemButton];
  
  //添加数据
  self.noteArray = [[NSArray alloc] initWithObjects:@"1",@"2",@"3", nil];
  
  
}

#pragma mark - 设置导航栏的按钮
- (void)setNavigationBarItemButton{
  
  //设置导航栏的背景颜色；
  [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:0.89 green:0.89 blue:0.89 alpha:1]];
  
  //设置界面的背景颜色
  self.view.backgroundColor = [UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1];
  
  
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

- (void)noteHeaderPressed:(id)sender{
  UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"这是TableView头部" preferredStyle:  UIAlertControllerStyleAlert];
  [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    //点击按钮的响应事件；
  }]];
  
  [self presentViewController:alert animated:true completion:nil];
  
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  
  return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NoteCell" forIndexPath:indexPath];
  cell.textLabel.text = [self.noteArray objectAtIndex:indexPath.row];
  return cell;
  
}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  return 50;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
  return 50;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
  UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width , 50)];
  
  //需要在Header底部加一条细线，用来分隔第一个cell；默认Header和第一个cell之间是没有分隔线的；
  
  UIImageView *noteIcon = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
  [noteIcon setImage:[UIImage imageNamed:@"tableview_note.png"]];
  
  UILabel *noteLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, 10, 50, 30)];
  noteLabel.text = @"笔记";
  noteLabel.textColor = [UIColor colorWithRed:0 green:0.6 blue:0.26 alpha:1];
  
  UILabel *totalLabel = [[UILabel alloc] initWithFrame:CGRectMake(tableView.bounds.size.width - 60, 10, 50, 30)];
  totalLabel.text = @"全部";
  totalLabel.textColor = [UIColor colorWithRed:0 green:0.6 blue:0.26 alpha:1];
  totalLabel.font = [UIFont systemFontOfSize:12];
  
  UIImageView *arrowIcon = [[UIImageView alloc] initWithFrame:CGRectMake(tableView.bounds.size.width - 30, 10, 30, 30)];
  [arrowIcon setImage:[UIImage imageNamed:@"tableview_arrow.png"]];
  
  
  //在Header底部绘制一条线；
  UIView *drawLine = [[UIView alloc] initWithFrame:CGRectMake(0, 49, tableView.bounds.size.width, 1)];
  drawLine.backgroundColor = [UIColor colorWithRed:0.89 green:0.89 blue:0.89 alpha:1];
  
  
  [view addSubview:noteIcon];
  [view addSubview:noteLabel];
  [view addSubview:totalLabel];
  [view addSubview:arrowIcon];
  [view addSubview:drawLine];
  
  //增加Header的点击事件；
  [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(noteHeaderPressed:)]];
  
  return view;
  
}

@end















