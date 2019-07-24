//
//  Province.m
//  2-14 字典转模型
//
//  Created by wujz on 16/5/15.
//  Copyright © 2016年 zucc. All rights reserved.
//

#import "Province.h"

@implementation Province
-(instancetype)initWithDict:(NSDictionary *)dict{
    //重构
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }

    return self;
}

+(instancetype)provinceWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}
@end
