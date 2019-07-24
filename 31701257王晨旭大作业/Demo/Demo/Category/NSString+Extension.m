//
//  NSString+Extension.m
//  Demo
//
//  Created by 王晨旭 on 2019/5/27.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

- (BOOL)numberOfLengthBiggerThanZero {
    NSString *str = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    return str.length > 0;
}

@end
