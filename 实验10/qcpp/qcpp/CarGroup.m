//
//  CarGroup.m
//  qcpp
//
//  Created by 王晨旭 on 2019/5/2.
//  Copyright © 2019 王晨旭. All rights reserved.
//
#import "Car.h"
#import "CarGroup.h"

@implementation CarGroup
+ (instancetype)groupWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
}

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        // 赋值标题
        self.title = dict[@"title"];
        
        // 取出原来的字典数组
        NSArray *dictArray = dict[@"cars"];
        NSMutableArray *carArray = [NSMutableArray array];
        for (NSDictionary *dict in dictArray) {
            Car *car = [Car carWithDict:dict];
            [carArray addObject:car];
        }
        self.cars = carArray;
    }
    return self;
}
@end
