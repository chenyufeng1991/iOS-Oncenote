
//
//  AllNotesViewController.m
//  Oncenote
//
//  Created by chenyufeng on 15/11/14.
//  Copyright © 2015年 chenyufengweb. All rights reserved.
//

#import "AllNotesViewController.h"
#import "NoteDetailViewController.h"

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
  
  
  [self dismissViewControllerAnimated:true completion:^{
    //
  }];
  
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





#pragma mark - 界面跳转传递数据
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
  
  if ([segue.identifier isEqualToString:@"NoteDetailSegue"]) {
    NoteDetailViewController *detail = (NoteDetailViewController*)segue.destinationViewController;
    NSIndexPath *indePath = self.noteTableView.indexPathForSelectedRow;
    detail.noteId = [[self.allNotesArray objectAtIndex:indePath.row] valueForKey:@"noteId"];
    detail.noteTitle = [[self.allNotesArray objectAtIndex:indePath.row] valueForKey:@"noteTitle"];
    detail.noteText = [[self.allNotesArray objectAtIndex:indePath.row] valueForKey:@"noteText"];
    
  }
  
  
  
}

@end













