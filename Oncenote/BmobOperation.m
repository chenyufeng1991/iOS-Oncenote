//
//  BmobOperation.m
//  Oncenote
//
//  Created by chenyufeng on 15/11/13.
//  Copyright © 2015年 chenyufengweb. All rights reserved.
//

#import "BmobOperation.h"
#import <BmobSDK/Bmob.h>

@implementation BmobOperation

//插入一条笔记到Note表，包括2个字段，userId,noteText;
- (void)addNoteToNoteTable:(NSString*)tableName userId:(NSString*)userId noteText:(NSString*)noteText{
  
  BmobObject *user = [BmobObject objectWithClassName:tableName];
  [user setObject:userId forKey:@"userId"];
  [user setObject:noteText forKey:@"noteText"];
  [user saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
    NSLog(@"插入一条笔记成功");
  }];
  
  
}



@end
