//
//  NoteDetailViewController.m
//  Oncenote
//
//  Created by chenyufeng on 15/11/14.
//  Copyright © 2015年 chenyufengweb. All rights reserved.
//

#import "NoteDetailViewController.h"

@interface NoteDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
@property (weak, nonatomic) IBOutlet UIImageView *shareImageView;
@property (weak, nonatomic) IBOutlet UIImageView *searchImageView;
@property (weak, nonatomic) IBOutlet UIImageView *addImageView;

@property (weak, nonatomic) IBOutlet UITextField *noteTitleTextField;
@property (weak, nonatomic) IBOutlet UITextView *noteTextTextView;

@end

@implementation NoteDetailViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.noteTitleTextField.text = self.noteTitle;
  self.noteTextTextView.text = self.noteText;
  NSLog(@"noteId;%@",self.noteId);
  
  
  //控件绑定操作；
  [self.backImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(noteDetailBackButtonPressed:)]];
  
}


#pragma mark - 所有的按钮点击操作
- (void) noteDetailBackButtonPressed:(id)sender{

  //使用显式界面跳转,因为需要执行MainViewController的viewDidLoad()方法；
  UIViewController *mainViewController = [[UIViewController alloc] init];
  mainViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
  [self presentViewController:mainViewController animated:true completion:nil];

}

@end
