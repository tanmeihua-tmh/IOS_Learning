//
//  CarGroup.m
//  2-16 表视图汽车品牌
//
//  Created by wujz on 16/5/15.
//  Copyright © 2016年 zucc. All rights reserved.
//

#import "car.h"
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
