//
//  StaffInfo.m
//  Demo
//
//  Created by 王晨旭 on 2019/5/28.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import "StaffInfo.h"

@implementation StaffInfo

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.name = [aDecoder decodeObjectOfClass:[NSString class] forKey:@"name"];
        self.studentNumber = [aDecoder decodeObjectOfClass:[NSString class] forKey:@"studentNumber"];
        self.QQNumber = [aDecoder decodeObjectOfClass:[NSString class] forKey:@"QQNumber"];
        self.phoneNumber = [aDecoder decodeObjectOfClass:[NSString class] forKey:@"phoneNumber"];
        self.WeChatNumber = [aDecoder decodeObjectOfClass:[NSString class] forKey:@"WeChatNumber"];
        self.emailNumber = [aDecoder decodeObjectOfClass:[NSString class] forKey:@"emailNumber"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.name forKey:@"name"];
    [coder encodeObject:self.studentNumber forKey:@"studentNumber"];
    [coder encodeObject:self.QQNumber forKey:@"QQNumber"];
    [coder encodeObject:self.phoneNumber forKey:@"phoneNumber"];
    [coder encodeObject:self.WeChatNumber forKey:@"WeChatNumber"];
    [coder encodeObject:self.emailNumber forKey:@"emailNumber"];
}

/**
 支持加密编码
 */
+ (BOOL)supportsSecureCoding{
    return YES;
}

@end
