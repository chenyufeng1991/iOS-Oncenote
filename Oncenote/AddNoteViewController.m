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
#import "AllUtils.h"


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
        
        [AllUtils showPromptDialog:@"提示" andMessage:@"增加一条笔记成功" OKButton:@"确定" OKButtonAction:^(UIAlertAction *action) {
          //跳回到主界面；
          [AllUtils jumpToViewController:@"MainViewController" contextViewController:self handler:nil];
          NSLog(@"回到主界面");
        } cancelButton:@"" cancelButtonAction:nil contextViewController:self];
      }else {

        [AllUtils showPromptDialog:@"提示" andMessage:@"服务器异常，增加笔记失败！" OKButton:@"确定" OKButtonAction:nil cancelButton:@"" cancelButtonAction:nil contextViewController:self];
      }
    }];
  }else{

    [AllUtils showPromptDialog:@"提示" andMessage:@"标题和内容缺一不可！" OKButton:@"确定" OKButtonAction:nil cancelButton:@"" cancelButtonAction:nil contextViewController:self];
  }
}

@end
