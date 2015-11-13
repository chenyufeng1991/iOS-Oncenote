//
//  ViewController.m
//  Oncenote
//
//  Created by chenyufeng on 15/11/12.
//  Copyright © 2015年 chenyufengweb. All rights reserved.
//


/*
 界面的背景灰色：[UIColor colorWithRed:0.89 green:0.89 blue:0.89 alpha:1] = 227，227，227
 主色调绿色：[UIColor colorWithRed:0 green:0.6 blue:0.26 alpha:1] = 0，135，66
 
 
 */

#import "MainViewController.h"
#import <BmobSDK/Bmob.h>
#import "BmobOperation.h"
#import "AppDelegate.h"

@interface MainViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *noteTableView;//“笔记”的TableView


@property(nonatomic,strong) NSArray *noteTitleArray;
@property(nonatomic,strong) NSArray *noteTimeArray;

@property (weak, nonatomic) IBOutlet UIImageView *naviSettingImage;
@property (weak, nonatomic) IBOutlet UIImageView *naviRefreshImage;
@property (weak, nonatomic) IBOutlet UIImageView *naviSearchImage;
@property (weak, nonatomic) IBOutlet UILabel *naviUsername;

@end

@implementation MainViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  //设置navi中的用户名；
  AppDelegate *app = [[UIApplication sharedApplication] delegate];
  self.naviUsername.text = app.GLOBAL_USERNAME;
  
  //添加数据;
  self.noteTitleArray = [[NSArray alloc] initWithObjects:@"1",@"2",@"3", nil];
  self.noteTimeArray = [[NSArray alloc] initWithObjects:@"2015.10.1",@"2011.1.1",@"1991.12.12", nil];
  
  //绑定控件；
  [self.naviSettingImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(naviSettingButtonPressed:)]];
  [self.naviRefreshImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(naviRefreshButtonPressed:)]];
  [self.naviSearchImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(naviSearchButtonPressed:)]];
  
  
  
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

  
}

- (void)noteHeaderPressed:(id)sender{
  
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  
  return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
  //设置TableView的圆角；
  tableView.layer.cornerRadius = 10;
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NoteCell" forIndexPath:indexPath];
  
  UILabel *noteTitle = (UILabel*)[cell viewWithTag:101];
  UILabel *noteTime = (UILabel*)[cell viewWithTag:102];
  
  noteTitle.text = [self.noteTitleArray objectAtIndex:indexPath.row];
  noteTime.text = [self.noteTimeArray objectAtIndex:indexPath.row];
  
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


//#pragma mark - Bmob数据处理
////往_User表增加一个用户；
//- (void)addUserToUserTable:(NSString*)tableName username:(NSString*)username password:(NSString*)password{
//  BmobObject *user = [BmobObject objectWithClassName:tableName];
//  [user setObject:username forKey:@"username"];
//  [user setObject:password forKey:@"password"];
//  [user saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
//    NSLog(@"插入一个用户成功");
//  }];
//}
//
////插入一条笔记到Note表，包括2个字段，userId,noteText;
//- (void)addNoteToNoteTable:(NSString*)tableName userId:(NSString*)userId noteText:(NSString*)noteText{
//  
//  BmobObject *user = [BmobObject objectWithClassName:tableName];
//  [user setObject:userId forKey:@"userId"];
//  [user setObject:noteText forKey:@"noteText"];
//  [user saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
//    NSLog(@"插入一条笔记成功");
//  }];
//  
//  
//}



@end















