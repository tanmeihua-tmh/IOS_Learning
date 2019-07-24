//
//  Flag.m
//  gqxz
//
//  Created by 王晨旭 on 2019/4/29.
//  Copyright © 2019 王晨旭. All rights reserved.
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
