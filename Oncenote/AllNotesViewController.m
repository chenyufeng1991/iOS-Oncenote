
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

@interface AllNotesViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
@property (weak, nonatomic) IBOutlet UIImageView *shareImageView;
@property (weak, nonatomic) IBOutlet UIImageView *searchImageView;


@property (weak, nonatomic) IBOutlet UITableView *noteTableView;


@end

@implementation AllNotesViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  
  //控件绑定操作；
  [self.backImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backButtonPressed:)]];
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



@end













