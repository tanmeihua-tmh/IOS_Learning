//
//  Provinces.m
//  dic
//
//  Created by 王晨旭 on 2019/4/29.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import "Provinces.h"

@implementation Provinces
-(instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    
    return self;
}

+(instancetype)provinceWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}
@end
