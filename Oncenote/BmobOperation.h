//
//  BmobOperation.h
//  Oncenote
//
//  Created by chenyufeng on 15/11/13.
//  Copyright © 2015年 chenyufengweb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BmobOperation : NSObject

+ (void)addNoteToNoteTable:(NSString*)tableName userId:(NSString*)userId  username:(NSString*)username  noteTitle:(NSString*)noteTitle noteText:(NSString*)noteText todo:(void(^)(BOOL isSuccessful, NSError *error)) todo;

+ (void)deleteNoteFromDatabase:(NSString*)tableName noteId:(NSString*)noteId;

//+ (void)updateNicknameToUserTable:(NSString*)tableName userId:(NSString*)userId nickname:(NSString*)nickname;
@end
