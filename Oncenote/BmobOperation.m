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

// - (void)showPromptDialog:(NSString*)title andMessage:(NSString*)message andButton:(NSString*)buttonTitle andAction:(void (^ __nullable)(UIAlertAction *action)) handler{
// 
// //尝试使用新的弹出对话框；
// UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
// [alertController addAction:[UIAlertAction actionWithTitle:buttonTitle style:UIAlertActionStyleDefault handler:handler]];
// //弹出提示框；
// [self presentViewController:alertController animated:true completion:nil];
// }


//(void (^)(id obj, NSUInteger idx, BOOL *stop))block


//往_User表增加一个用户；
- (void)addUserToUserTable:(NSString*)tableName username:(NSString*)username password:(NSString*)password todo: (void(^)(BOOL isSuccessful, NSError *error)) todo{
  BmobObject *user = [BmobObject objectWithClassName:tableName];
  [user setObject:username forKey:@"username"];
  [user setObject:password forKey:@"password"];
  [user saveInBackgroundWithResultBlock: todo];
}

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
