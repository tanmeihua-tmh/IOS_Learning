//
//  Car.m
//  ex04
//
//  Created by 王晨旭 on 2019/3/20.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import "Car.h"
@interface Car ()
-(void)drive;
@end
@implementation Car
-(void)run{
    [self drive];
    NSLog(@"car is running");
}
-(void)drive{
    NSLog(@"someone is driving");
}
@end
