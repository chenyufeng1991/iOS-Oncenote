
//
//  AllUtils.m
//  Oncenote
//
//  Created by chenyufeng on 15/11/15.
//  Copyright © 2015年 chenyufengweb. All rights reserved.
//

#import "AllUtils.h"

@implementation AllUtils

#pragma mark - 获取日期
+ (NSString *)getDateFromString:(NSString*)date{
  
  NSString * str = date;
  NSMutableString * reverseString = [NSMutableString string];
  for(int i = 0 ; i < str.length; i ++){
    //倒序读取字符并且存到可变数组数组中
    unichar c = [str characterAtIndex:str.length- i -1];
    [reverseString appendFormat:@"%c",c];
  }
  str = reverseString;
  //  NSLog(@"%@",str);//date已经逆转；
  
  NSString *b = [str substringFromIndex:8];//截取后8位；
  
  
  NSString * str2 = b;
  NSMutableString * reverseString2 = [NSMutableString string];
  for(int i = 0 ; i < str2.length; i ++){
    //倒序读取字符并且存到可变数组数组中
    unichar c = [str2 characterAtIndex:str2.length- i -1];
    [reverseString2 appendFormat:@"%c",c];
  }
  str2 = reverseString2;
  //  NSLog(@"%@",str2);//date转换完毕
  
  return str2;
}

@end
