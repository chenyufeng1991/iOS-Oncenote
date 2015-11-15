//
//  AllNoteDetailViewController.m
//  Oncenote
//
//  Created by chenyufeng on 15/11/15.
//  Copyright © 2015年 chenyufengweb. All rights reserved.
//

#import "AllNoteDetailViewController.h"

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
  [self.backImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backButtonPressed:)]];
  
}


#pragma mark - 所有的按钮点击操作
- (void) backButtonPressed:(id)sender{
  
  
  [self dismissViewControllerAnimated:true completion:^{
    //
  }];
  
}


@end
