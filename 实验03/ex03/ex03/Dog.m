//
//  Dog.m
//  ex03
//
//  Created by 王晨旭 on 2019/3/13.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import "Dog.h"

@implementation Dog
-(void)eat{
    NSLog(@"Dog is eating");
}
-(void)bark{
    [super eat];
    [self eat];
}
@end
