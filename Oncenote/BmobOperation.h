//
//  BmobOperation.h
//  Oncenote
//
//  Created by chenyufeng on 15/11/13.
//  Copyright © 2015年 chenyufengweb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BmobOperation : NSObject

- (void)addUserToUserTable:(NSString*)tableName username:(NSString*)username password:(NSString*)password todo: (void(^)(BOOL isSuccessful, NSError *error)) todo;
- (void)addNoteToNoteTable:(NSString*)tableName userId:(NSString*)userId noteText:(NSString*)noteText;
@end
