//
//  Flag.m
//  2-15 国旗选择
//
//  Created by wujz on 16/5/15.
//  Copyright © 2016年 zucc. All rights reserved.
//

#import "Flag.h"

@implementation Flag
-(instancetype)initWithDict:(NSDictionary *)dict{

    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+(instancetype)flagWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}

@end
