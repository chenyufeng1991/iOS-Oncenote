
//
//  SettingList.m
//  Oncenote
//
//  Created by chenyufeng on 15/11/17.
//  Copyright © 2015年 chenyufengweb. All rights reserved.
//

#import "SettingList.h"

@implementation SettingList

- (instancetype)init{

  self = [super init];
  if (self) {

    self.settingListArray = [[NSArray alloc] initWithObjects:@"个人资料",@"修改密码",@"应用官网",@"关于", nil];
  }
  return self;
}

@end
