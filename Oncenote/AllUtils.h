//
//  AllUtils.h
//  Oncenote
//
//  Created by chenyufeng on 15/11/15.
//  Copyright © 2015年 chenyufengweb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AllUtils : NSObject

+ (NSString *)getDateFromString:(NSString*)date;

+ (UIAlertController*)showPromptDialog:(NSString*)title andMessage:(NSString*)message OKButton:(NSString*)OKButtonTitle OKButtonAction:(void (^)(UIAlertAction *action))OKButtonHandler cancelButton:(NSString*)cancelButtonTitle cancelButtonAction:(void (^)(UIAlertAction *action))cancelButtonHandler contextViewController:(UIViewController*)contextViewController;

+ (void)jumpToViewController:(NSString*)viewControllerIdentifier contextViewController:(UIViewController*)contextViewController handler:(void (^)(void))handler;
@end
