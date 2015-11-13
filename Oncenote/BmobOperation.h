//
//  BmobOperation.h
//  Oncenote
//
//  Created by chenyufeng on 15/11/13.
//  Copyright © 2015年 chenyufengweb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BmobOperation : NSObject

- (void)addNoteToNoteTable:(NSString*)tableName userId:(NSString*)userId noteTitle:(NSString*)noteTitle noteText:(NSString*)noteText todo:(void(^)(BOOL isSuccessful, NSError *error)) todo;
@end
