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
- (void)addNoteToNoteTable:(NSString*)tableName userId:(NSString*)userId noteTitle:(NSString*)noteTitle noteText:(NSString*)noteText todo:(void(^)(BOOL isSuccessful, NSError *error)) todo{
  
  BmobObject *note = [BmobObject objectWithClassName:tableName];
  [note setObject:userId forKey:@"userId"];
  [note setObject:noteTitle forKey:@"noteTitle"];
  [note setObject:noteText forKey:@"noteText"];
  [note saveInBackgroundWithResultBlock:todo];
  
  
}



@end
