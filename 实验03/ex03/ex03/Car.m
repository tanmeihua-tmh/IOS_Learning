//
//  Car.m
//  ex03
//
//  Created by 王晨旭 on 2019/3/13.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import "Car.h"

@implementation Car
-(id)init{
    self = [super init];
    if(self!= nil){
        _price=150000;
        _speed=150;
    }
    return self;
}
-(NSString *)description{
    return [NSString stringWithFormat:@"price = %f,speed = %d",_price,_speed];
}
@end
