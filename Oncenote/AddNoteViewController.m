//
//  AddNoteViewController.m
//  Oncenote
//
//  Created by chenyufeng on 15/11/13.
//  Copyright © 2015年 chenyufengweb. All rights reserved.
//

#import "AddNoteViewController.h"
#import "BmobOperation.h"
#import "Constant.h"
#import "AppDelegate.h"
#import "MainViewController.h"

@interface AddNoteViewController ()

@property (weak, nonatomic) IBOutlet UITextField *noteTitleTextField;
@property (weak, nonatomic) IBOutlet UITextView *noteTextTextView;

@end

@implementation AddNoteViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  
  
  
}


#pragma mark - 所有按钮的点击事件
- (IBAction)naviStoreButtonPressed:(id)sender {
  AppDelegate *app = [[UIApplication sharedApplication] delegate];
  
  NSString *userId = app.GLOBAL_USERID;
  NSString *username = app.GLOBAL_USERNAME;
  NSString *noteTitle = [self.noteTitleTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
  NSString *noteText = [self.noteTextTextView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
  
  if (![noteTitle  isEqual: @""] && ![noteText  isEqual: @""]){
    
//    BmobOperation *operate = [[BmobOperation alloc] init];
    [BmobOperation addNoteToNoteTable:NOTE_TABLE userId:userId  username:username noteTitle:noteTitle noteText:noteText todo:^(BOOL isSuccessful, NSError *error) {
      if (isSuccessful) {
        [self showPromptDialog:@"提示" andMessage:@"增加一条笔记成功" andButton:@"确定" andAction:^(UIAlertAction *action) {
          //跳回到主界面；
          UIViewController *mainViewController = [[UIViewController alloc] init];
          mainViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
          [self presentViewController:mainViewController animated:true completion:nil];
          NSLog(@"回到主界面");
        }];
      }else {
        [self showPromptDialog:@"提示" andMessage:@"服务器异常，增加笔记失败。" andButton:@"确定" andAction:nil];
      }
    }];
  }else{
    [self showPromptDialog:@"提示" andMessage:@"标题和内容缺一不可。" andButton:@"确定" andAction:nil];
  }
  
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




















