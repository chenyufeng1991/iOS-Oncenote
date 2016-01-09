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
#import "NoteDetailViewController.h"
#import "AllNotesViewController.h"
#import "Constant.h"
#import "AllUtils.h"
#import "SettingViewController.h"

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
  //  NSLog(@"22222222222222用户的昵称是:%@",app.GLOBAL_NICKNAME);
  if (app.GLOBAL_NICKNAME == nil || [app.GLOBAL_NICKNAME isEqualToString:@""]) {

    self.naviUsername.text = app.GLOBAL_USERNAME;
  } else {

    self.naviUsername.text = app.GLOBAL_NICKNAME;
  }
  //绑定控件；
  [self.naviSettingImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(naviSettingButtonPressed:)]];
  [self.naviRefreshImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(naviRefreshButtonPressed:)]];
  [self.naviSearchImage addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(naviSearchButtonPressed:)]];
  //绑定图片;
  [self.textImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(textImageButtonPressed:)]];
  //查询用户的笔记；
  [self queryNoteByUserId:NOTE_TABLE userId:app.GLOBAL_USERID limitCount:50];
}

#pragma mark - 所有的按钮点击事件
//点击导航栏左侧的设置按钮；
- (void)naviSettingButtonPressed:(id)sender{

  [AllUtils jumpToViewController:@"SettingViewController" contextViewController:self handler:nil];
}

- (void)naviRefreshButtonPressed:(id)sender{
  
}

//点击导航栏搜索按钮；
- (void)naviSearchButtonPressed:(id)sender{

}

//点击Header,跳转到所有笔记页面；
- (void)noteHeaderPressed:(id)sender{

  [AllUtils jumpToViewController:@"AllNotesViewController" contextViewController:self handler:nil];
}

//跳转到新增笔记的页面-->AddNoteViewController;
- (void)textImageButtonPressed:(id)sender{
  
  [AllUtils jumpToViewController:@"AddNoteViewController" contextViewController:self handler:nil];
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
  //这里需要截取字符串，只要显示日期即可，不需要时分秒；
  noteTime.text = [[self.notesArray objectAtIndex:indexPath.row] valueForKey:@"noteCreatedAt"];
  
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
  //以updatedAt进行降序排列；
  [queryNote orderByDescending:@"updatedAt"];
  queryNote.limit = limitCount;
  [queryNote findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
    
    if (error) {

      //      NSLog(@"查询笔记错误");
    } else {

      //      NSLog(@"正在查询笔记。。。");
      for (BmobObject *obj in array) {
        
        Notes *note = [[Notes alloc] init];
        if ([(NSString*)[obj objectForKey:@"userId"] isEqualToString:userId]) {
          
          note.noteId = [obj objectForKey:@"objectId"];
          note.userId = [obj objectForKey:@"userId"];
          note.username = [obj objectForKey:@"username"];
          note.noteTitle = [obj objectForKey:@"noteTitle"];
          note.noteText = [obj objectForKey:@"noteText"];
          note.noteCreatedAt = [AllUtils getDateFromString:[obj objectForKey:@"createdAt"]];
          
          [_notesArray addObject:note];
        }//if();
      }//for();
      
      if (self.tempTitle != nil && self.tempText != nil && self.tempIndexPath != nil) {
        
        [[self.notesArray objectAtIndex:self.tempIndexPath.row] setValue:self.tempTitle forKey:@"noteTitle"];
        [[self.notesArray objectAtIndex:self.tempIndexPath.row] setValue:self.tempText forKey:@"noteText"];
        for (int i = (int)self.tempIndexPath.row ; i >= 1; i--) {

          [self.notesArray exchangeObjectAtIndex:i withObjectAtIndex:i-1];//这样是可以的；
        }//for()
      }
    }//else();
    
    //    NSLog(@"笔记数组的count = %lu",(unsigned long)[self.notesArray count]);
    self.noteTableView.frame = CGRectMake(self.noteTableView.frame.origin.x, self.noteTableView.frame.origin.y, self.noteTableView.frame.size.width, (([self.notesArray count] > 3 ? 3 : [self.notesArray count]) + 1) * 50);
    [self.noteTableView reloadData];
  }];
}

#pragma mark - 懒加载显示笔记内容
//这里标题的添加也使用懒加载；
- (NSMutableArray *)notesArray{
  
  Notes *note = [[Notes alloc] init];
  note.noteId = @"";
  note.userId = @"";
  note.username = @"";
  note.noteTitle = @"";
  note.noteText = @"";
  note.noteCreatedAt = @"";
  if (!_notesArray) {

    self.notesArray = [[NSMutableArray alloc] initWithCapacity:3];
  }
  return _notesArray;
}

#pragma mark - 界面跳转传递数据
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
  
  if ([segue.identifier isEqualToString:@"NoteDetailSegue"]) {
    NoteDetailViewController *detail = (NoteDetailViewController*)segue.destinationViewController;
    NSIndexPath *indePath = self.noteTableView.indexPathForSelectedRow;
    detail.noteId = [[self.notesArray objectAtIndex:indePath.row] valueForKey:@"noteId"];
    detail.noteTitle = [[self.notesArray objectAtIndex:indePath.row] valueForKey:@"noteTitle"];
    detail.noteText = [[self.notesArray objectAtIndex:indePath.row] valueForKey:@"noteText"];

    detail.indexPath = indePath;
  }
}

@end
