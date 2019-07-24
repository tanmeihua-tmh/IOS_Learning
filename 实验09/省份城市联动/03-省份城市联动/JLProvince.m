//
//  JLProvince.m
//  03-省份城市联动
//
//  Created by 王晨旭 on 2019/4/24.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import "JLProvince.h"

@implementation JLProvince

- (instancetype)initWithDict:(NSDictionary *)dict{

    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    
    return self;
}

+ (instancetype)provinceWithDict:(NSDictionary *)dict{

    return [[self alloc] initWithDict:dict];
}

@end
