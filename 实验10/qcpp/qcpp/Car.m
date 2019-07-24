//
//  Car.m
//  qcpp
//
//  Created by 王晨旭 on 2019/5/2.
//  Copyright © 2019 王晨旭. All rights reserved.
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
