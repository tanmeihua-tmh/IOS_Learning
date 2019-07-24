//
//  Car.m
//  2-16 表视图汽车品牌
//
//  Created by wujz on 16/5/15.
//  Copyright © 2016年 zucc. All rights reserved.
//

#import "Car.h"

@implementation Car
+ (instancetype)carWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
@end
