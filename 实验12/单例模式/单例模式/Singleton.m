//
//  Singleton.m
//  单例模式
//
//  Created by 王晨旭 on 2019/5/15.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import "Singleton.h"

@implementation Singleton
static Singleton *_singgleton=nil;
+(id)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{_singgleton = [super allocWithZone:zone];});
    return _singgleton;
}
+(Singleton *)shareSingleton{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{_singgleton = [[Singleton alloc]init];});
    return _singgleton;
}
+(id)copyWithZone:(struct _NSZone *)zone{
    return _singgleton;
}

@end

