//
//  Person.m
//  6-5 对象归档
//
//  Created by wujz on 16/6/4.
//  Copyright © 2016年 zucc. All rights reserved.
//

#import "Person.h"
@implementation Person

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.name forKey:@"Name"];
    [aCoder encodeInt:self.age forKey:@"Age"];
    [aCoder encodeFloat:self.height forKey:@"Height"];
    [aCoder encodeFloat:self.weight forKey:@"Weight"];
}
-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self=[super init]) {
        self.name=[aDecoder decodeObjectForKey:@"Name"];
        self.age = [aDecoder decodeIntForKey:@"Age"] ;
        self.height =[aDecoder decodeFloatForKey:@"Height"];
        self.weight=[aDecoder decodeFloatForKey:@"Weight"];
    }
    return self;
}


-(NSString *)description{
    return [NSString stringWithFormat:@"name = %@, age = %d,height = %0.1f, weight = %0.1f",_name, _age, _height, _weight];
}
@end
