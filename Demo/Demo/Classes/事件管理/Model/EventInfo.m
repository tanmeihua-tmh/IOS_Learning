//
//  EventInfo.m
//  Demo
//
//  Created by 王晨旭 on 2019/5/27.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import "EventInfo.h"

@implementation EventInfo

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.descript forKey:@"descript"];
    [aCoder encodeObject:self.detailInfo forKey:@"detailInfo"];
    [aCoder encodeObject:self.endTime forKey:@"endTime"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.title = [aDecoder decodeObjectOfClass:[NSString class] forKey:@"title"];
        self.descript = [aDecoder decodeObjectOfClass:[NSString class] forKey:@"descript"];
        self.detailInfo = [aDecoder decodeObjectOfClass:[NSString class] forKey:@"detailInfo"];
        self.endTime = [aDecoder decodeObjectOfClass:[NSDate class] forKey:@"endTime"];
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
