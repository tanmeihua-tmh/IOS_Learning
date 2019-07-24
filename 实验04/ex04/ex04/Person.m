//
//  Person.m
//  ex04
//
//  Created by 王晨旭 on 2019/3/20.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import "Person.h"
#import "Car.h"
@implementation Person
-(void)persondrive{
    Car *c=[[Car alloc]init];
    [c run];
}
@end
