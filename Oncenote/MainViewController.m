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
#import "AppDelegate.h"
#import "Notes.h"

@interface MainViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *noteTableView;//“笔记”的TableView

@property (weak, nonatomic) IBOutlet UIImageView *naviSettingImage;
@property (weak, nonatomic) IBOutlet UIImageView *naviRefreshImage;
@property (weak, nonatomic) IBOutlet UIImageView *naviSearchImage;
@property (weak, nonatomic) IBOutlet UILabel *naviUsername;


@property (weak, nonatomic) IBOutlet UIImageView *textImageView;

//存放笔记对象的可变数组；
@property(nonatomic,strong) NSMutableArray *notesArray;



@end

@implementation MainViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  //设置navi中的用户名；
  AppDelegate *app = [[UIApplication sharedApplication] delegate];
  self.naviUsername.text = app.GLOBAL_USERNAME;
  
  //绑定控件；
  [self.naviSettingImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(naviSettingButtonPressed:)]];
  [self.naviRefreshImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(naviRefreshButtonPressed:)]];
  [self.naviSearchImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(naviSearchButtonPressed:)]];
  
  //绑定图片;
  [self.textImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(textImageButtonPressed:)]];
  
  
  
  
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

//点击导航栏搜索按钮；
- (void)naviSearchButtonPressed:(id)sender{
  
  NSLog(@"点击了搜索按钮");
  
  AppDelegate *app = [[UIApplication sharedApplication] delegate];
  
  [self queryNoteByUserId:@"Note" userId:app.GLOBAL_USERID limitCount:50];
  
}

- (void)noteHeaderPressed:(id)sender{
  
}

//跳转到新增笔记的页面-->AddNoteViewController;
- (void)textImageButtonPressed:(id)sender{
  UIViewController *addNoteViewController = [[UIViewController alloc] init];
  addNoteViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"AddNoteViewController"];
  [self presentViewController:addNoteViewController animated:true completion:^{
    //todo;
  }];
  
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  
  return [self.notesArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
  //设置TableView的圆角；
  tableView.layer.cornerRadius = 10;
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NoteCell" forIndexPath:indexPath];
  
  UILabel *noteTitle = (UILabel*)[cell viewWithTag:101];
  UILabel *noteTime = (UILabel*)[cell viewWithTag:102];
  
  
  noteTitle.text = [[self.notesArray objectAtIndex:indexPath.row] valueForKey:@"noteTitle"];
  noteTime.text = @"今天";
  
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


#pragma mark - 查询该用户的笔记

- (void) queryNoteByUserId:(NSString*)tableName userId:(NSString*)userId limitCount:(int)limitCount{
  
  BmobQuery *queryNote = [BmobQuery queryWithClassName:tableName];
  queryNote.limit = limitCount;
  [queryNote findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
    
    if (error) {
      NSLog(@"查询笔记错误");
    } else {
      NSLog(@"正在查询笔记。。。");
      for (BmobObject *obj in array) {
        
        Notes *note = [[Notes alloc] init];
        
        if ([(NSString*)[obj objectForKey:@"userId"] isEqualToString:userId]) {
          
          note.userId = [obj objectForKey:@"userId"];
          note.username = [obj objectForKey:@"username"];
          note.noteTitle = [obj objectForKey:@"noteTitle"];
          note.noteText = [obj objectForKey:@"noteText"];
          
          [_notesArray addObject:note];
          
          NSLog(@"输入的用户Id：%@,返回的用户Id：%@,标题：%@,笔记内容：%@",userId,[obj objectForKey:@"userId"],[obj objectForKey:@"noteTitle"],[obj objectForKey:@"noteText"]);
        }
      }//for();
    }//else();
    
    [self.noteTableView reloadData];
    
    
    
  }];
  
}

#pragma mark - 懒加载显示笔记内容
//这里标题的添加也使用懒加载；
- (NSMutableArray *)notesArray{
  
  Notes *note = [[Notes alloc] init];
  note.userId = @"";
  note.username = @"";
  note.noteTitle = @"";
  note.noteText = @"";
  
  if (!_notesArray) {
//    self.notesArray = [[NSMutableArray alloc] initWithObjects:note,note,note, nil];
    
    self.notesArray = [[NSMutableArray alloc] initWithCapacity:3];
  }
  
  return _notesArray;
}


@end

















