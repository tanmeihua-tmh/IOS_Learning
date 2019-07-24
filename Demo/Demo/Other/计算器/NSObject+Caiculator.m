//
//  NSObject+Caiculator.m
//  Demo
//
//  Created by 王晨旭 on 2019/5/30.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import "NSObject+Caiculator.h"

@implementation NSObject (Caiculator)

+(CGFloat)makeCalculateMethod:(void (^)(Calculate * _Nonnull calculator))block {
    Calculate *calculator = [[Calculate alloc] init];
    block(calculator);
    return calculator.result;
}

@end
