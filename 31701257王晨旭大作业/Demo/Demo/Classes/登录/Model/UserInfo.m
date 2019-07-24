//
//  UserInfo.m
//  Demo
//
//  Created by 王晨旭 on 2019/5/27.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.userName forKey:@"userName"];
    [aCoder encodeObject:self.password forKey:@"password"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.userName = [aDecoder decodeObjectOfClass:[NSString class] forKey:@"userName"];
        self.password = [aDecoder decodeObjectOfClass:[NSString class] forKey:@"password"];
    }
    return self;
}

/**
 支持加密编码
 */
+ (BOOL)supportsSecureCoding{
    return YES;
}

@end
