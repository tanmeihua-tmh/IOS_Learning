//
//  MJContact.m
//  01-私人通讯录
//
//  Created by apple on 14-4-10.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "MJContact.h"

@implementation MJContact
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeObject:self.phone forKey:@"phone"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.name = [decoder decodeObjectForKey:@"name"];
        self.phone = [decoder decodeObjectForKey:@"phone"];
    }
    return self;
}
@end
