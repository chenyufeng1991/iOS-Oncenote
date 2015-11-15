//
//  AllNoteDetailViewController.m
//  Oncenote
//
//  Created by chenyufeng on 15/11/15.
//  Copyright © 2015年 chenyufengweb. All rights reserved.
//

#import "AllNoteDetailViewController.h"
#import <BmobSDK/Bmob.h>
#import "Constant.h"
#import "AllNotesViewController.h"
#import "AppDelegate.h"
#import "MainViewController.h"

@interface AllNoteDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
@property (weak, nonatomic) IBOutlet UIImageView *shareImageView;
@property (weak, nonatomic) IBOutlet UIImageView *searchImageView;
@property (weak, nonatomic) IBOutlet UIImageView *addImageView;

@property (weak, nonatomic) IBOutlet UITextField *noteTitleTextField;
@property (weak, nonatomic) IBOutlet UITextView *noteTextTextView;


@end

@implementation AllNoteDetailViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  
  self.noteTitleTextField.text = self.noteTitle;
  self.noteTextTextView.text = self.noteText;
  NSLog(@"noteId;%@",self.noteId);
  
  
  //控件绑定操作；
  [self.backImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(allNoteDetailBackButtonPressed:)]];
  
}


#pragma mark - 所有的按钮点击操作
- (void) allNoteDetailBackButtonPressed:(id)sender{

  [self updateBmobObject:NOTE_TABLE noteId:self.noteId noteTitle:self.noteTitleTextField.text noteText:self.noteTextTextView.text];
  
}

#pragma mark - 修改笔记
-(void)updateBmobObject:(NSString*)tableName  noteId:(NSString*)noteId noteTitle:(NSString*)noteTitle noteText:(NSString*)noteText{
  //查找GameScore表
  BmobQuery   *bquery = [BmobQuery queryWithClassName:tableName];
  [bquery getObjectInBackgroundWithId:noteId block:^(BmobObject *object,NSError *error){
    if (!error) {
      if (object) {
        //设置cheatMode为YES
        [object setObject:noteTitle forKey:@"noteTitle"];
        [object setObject:noteText forKey:@"noteText"];
        
        //异步更新数据
        [object updateInBackground];
      }
    }else{
      //进行错误处理
    }
  }];
  
  
  
  //使用显式界面跳转,因为需要执行MainViewController的viewDidLoad()方法；
  MainViewController *mainViewController = [[MainViewController alloc] init];
  mainViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
  mainViewController.tempIndexPath = self.indexPath;
  mainViewController.tempTitle = self.noteTitleTextField.text;
  mainViewController.tempText = self.noteTextTextView.text;
  
  [self presentViewController:mainViewController animated:true completion:nil];
  
  
}


#pragma mark - 弹出提示对话框
- (void)showPromptDialog:(NSString*)title andMessage:(NSString*)message andButton:(NSString*)buttonTitle andAction:(void (^ __nullable)(UIAlertAction *action)) handler{
  
  //尝试使用新的弹出对话框；
  UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
  [alertController addAction:[UIAlertAction actionWithTitle:buttonTitle style:UIAlertActionStyleDefault handler:handler]];
  //弹出提示框；
  [self presentViewController:alertController animated:true completion:nil];
}


@end
























