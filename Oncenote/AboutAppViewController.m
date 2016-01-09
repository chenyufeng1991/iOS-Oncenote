//
//  AboutAppViewController.m
//  Oncenote
//
//  Created by chenyufeng on 15/11/17.
//  Copyright © 2015年 chenyufengweb. All rights reserved.
//

#import "AboutAppViewController.h"
#import "AllUtils.h"

@interface AboutAppViewController ()

@end

@implementation AboutAppViewController

- (void)viewDidLoad {

    [super viewDidLoad];
}

- (IBAction)naviBackButtonPressed:(id)sender {
  
  [AllUtils jumpToViewController:@"SettingViewController" contextViewController:self handler:nil];
}

@end
