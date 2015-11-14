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

//插入一条笔记到Note表，包括，userId(用户ID),username(用户名)，noteTitle（笔记标题），noteText（笔记内容）;4个字段；
- (void)addNoteToNoteTable:(NSString*)tableName userId:(NSString*)userId  username:(NSString*)username  noteTitle:(NSString*)noteTitle noteText:(NSString*)noteText todo:(void(^)(BOOL isSuccessful, NSError *error)) todo{
  
  BmobObject *note = [BmobObject objectWithClassName:tableName];
  [note setObject:userId forKey:@"userId"];
  [note setObject:username forKey:@"username"];
  [note setObject:noteTitle forKey:@"noteTitle"];
  [note setObject:noteText forKey:@"noteText"];
  [note saveInBackgroundWithResultBlock:todo];
  
  
}



@end
