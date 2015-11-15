
//
//  AllNotesViewController.m
//  Oncenote
//
//  Created by chenyufeng on 15/11/14.
//  Copyright © 2015年 chenyufengweb. All rights reserved.
//

#import "AllNotesViewController.h"
#import "NoteDetailViewController.h"
#import <BmobSDK/Bmob.h>
#import "Constant.h"
#import "MainViewController.h"
#import "AllNoteDetailViewController.h"
#import "AppDelegate.h"
#import "Notes.h"

@interface AllNotesViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
@property (weak, nonatomic) IBOutlet UIImageView *shareImageView;
@property (weak, nonatomic) IBOutlet UIImageView *searchImageView;


@property (weak, nonatomic) IBOutlet UITableView *noteTableView;


//存放笔记对象的可变数组；
@property(nonatomic,strong) NSMutableArray *allNotesArray;

@end

@implementation AllNotesViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  //设置navi中的用户名；
  AppDelegate *app = [[UIApplication sharedApplication] delegate];
  
  
  //控件绑定操作；
  [self.backImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backButtonPressed:)]];
  
  
  //查询用户的笔记；
  [self queryNoteByUserId:NOTE_TABLE userId:app.GLOBAL_USERID limitCount:50];
}


#pragma mark - 所有的按钮点击操作
- (void) backButtonPressed:(id)sender{
  //  [self dismissViewControllerAnimated:true completion:^{
  //    //
  //  }];
  
  //使用显式界面跳转,因为需要执行MainViewController的viewDidLoad()方法；
  UIViewController *mainViewController = [[UIViewController alloc] init];
  mainViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
  [self presentViewController:mainViewController animated:true completion:nil];

  
  
  
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  
  return [self.allNotesArray count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NoteCell" forIndexPath:indexPath];
  UILabel *noteTitle = (UILabel*)[cell viewWithTag:101];
  UILabel *noteTime = (UILabel*)[cell viewWithTag:102];
  UILabel *noteText = (UILabel*)[cell viewWithTag:103];
  
  noteTitle.text = [[self.allNotesArray objectAtIndex:indexPath.row] valueForKey:@"noteTitle"];
  noteTime.text = [[self.allNotesArray objectAtIndex:indexPath.row] valueForKey:@"noteCreatedAt"];
  noteText.text = [[self.allNotesArray objectAtIndex:indexPath.row] valueForKey:@"noteText"];
  
  return cell;
}


#pragma mark - UITableViewDelegate
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
  
  return true;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
  
  //左滑删除；
  if (editingStyle == UITableViewCellEditingStyleDelete) {
    
    [self deleteNoteFromDatabase:NOTE_TABLE noteId:[[self.allNotesArray objectAtIndex:indexPath.row] valueForKey:@"noteId"]];
    
    [self.allNotesArray removeObjectAtIndex:indexPath.row];//从数组中删除该值；
    [self.noteTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
    //数据库删除；
    
  }
  
}





#pragma mark - 界面跳转传递数据
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
  
  if ([segue.identifier isEqualToString:@"NoteDetailSegue"]) {
    AllNoteDetailViewController *detail = (AllNoteDetailViewController*)segue.destinationViewController;
    NSIndexPath *indePath = self.noteTableView.indexPathForSelectedRow;
    detail.noteId = [[self.allNotesArray objectAtIndex:indePath.row] valueForKey:@"noteId"];
    detail.noteTitle = [[self.allNotesArray objectAtIndex:indePath.row] valueForKey:@"noteTitle"];
    detail.noteText = [[self.allNotesArray objectAtIndex:indePath.row] valueForKey:@"noteText"];
    
  }
  
}


#pragma mark - 往数据库中删除一条笔记
- (void)deleteNoteFromDatabase:(NSString*)tableName noteId:(NSString*)noteId{
  
  BmobQuery *delete = [BmobQuery queryWithClassName:tableName];
  [delete getObjectInBackgroundWithId:noteId block:^(BmobObject *object, NSError *error){
    if (error) {
      //进行错误处理
    }
    else{
      if (object) {
        //异步删除object
        [object deleteInBackground];
      }
    }
  }];
}

#pragma mark - 查询该用户的笔记
- (void) queryNoteByUserId:(NSString*)tableName userId:(NSString*)userId limitCount:(int)limitCount{
  
  BmobQuery *queryNote = [BmobQuery queryWithClassName:tableName];
  [queryNote orderByDescending:@"updatedAt"];
  queryNote.limit = limitCount;
  [queryNote findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
    
    if (error) {
      NSLog(@"查询笔记错误");
    } else {
      NSLog(@"正在查询笔记。。。");
      for (BmobObject *obj in array) {
        
        Notes *note = [[Notes alloc] init];
        
        if ([(NSString*)[obj objectForKey:@"userId"] isEqualToString:userId]) {
          
          note.noteId = [obj objectForKey:@"objectId"];
          note.userId = [obj objectForKey:@"userId"];
          note.username = [obj objectForKey:@"username"];
          note.noteTitle = [obj objectForKey:@"noteTitle"];
          note.noteText = [obj objectForKey:@"noteText"];
          note.noteCreatedAt = [self getDateFromString:[obj objectForKey:@"createdAt"]];
          
          
          [_allNotesArray addObject:note];
          
          NSLog(@"输入的用户Id：%@,返回的用户Id：%@,标题：%@,笔记内容：%@",userId,[obj objectForKey:@"userId"],[obj objectForKey:@"noteTitle"],[obj objectForKey:@"noteText"]);
        }//if();
      }//for();
    }//else();
    
    NSLog(@"笔记数组的count = %lu",(unsigned long)[self.allNotesArray count]);
    
    self.noteTableView.frame = CGRectMake(self.noteTableView.frame.origin.x, self.noteTableView.frame.origin.y, self.noteTableView.frame.size.width, [self.allNotesArray count] * 100);
    
    [self.noteTableView reloadData];
    
  }];
  
}

#pragma mark - 懒加载显示笔记内容
//这里标题的添加也使用懒加载；
- (NSMutableArray *)allNotesArray{
  
  Notes *note = [[Notes alloc] init];
  note.noteId = @"";
  note.userId = @"";
  note.username = @"";
  note.noteTitle = @"";
  note.noteText = @"";
  note.noteCreatedAt = @"";
  
  if (!_allNotesArray) {
    self.allNotesArray = [[NSMutableArray alloc] initWithCapacity:3];
  }
  
  return _allNotesArray;
}

#pragma mark - 获取日期
- (NSString *)getDateFromString:(NSString*)date{
  
  NSString * str = date;
  NSMutableString * reverseString = [NSMutableString string];
  for(int i = 0 ; i < str.length; i ++){
    //倒序读取字符并且存到可变数组数组中
    unichar c = [str characterAtIndex:str.length- i -1];
    [reverseString appendFormat:@"%c",c];
  }
  str = reverseString;
  //  NSLog(@"%@",str);//date已经逆转；
  
  NSString *b = [str substringFromIndex:8];//截取后8位；
  
  
  NSString * str2 = b;
  NSMutableString * reverseString2 = [NSMutableString string];
  for(int i = 0 ; i < str2.length; i ++){
    //倒序读取字符并且存到可变数组数组中
    unichar c = [str2 characterAtIndex:str2.length- i -1];
    [reverseString2 appendFormat:@"%c",c];
  }
  str2 = reverseString2;
  //  NSLog(@"%@",str2);//date转换完毕
  
  return str2;
}

@end













