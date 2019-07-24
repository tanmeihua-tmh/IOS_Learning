//
//  Animal.m
//  ex03
//
//  Created by 王晨旭 on 2019/3/13.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import "Animal.h"

@implementation Animal
-(void)setWeight:(int)weight
{
    self->weight=weight;
}
-(void)setAge:(int)age
{
    self->age=age;
}
-(int)getAge{
    return age;
}
-(int)getWeight{
    return weight;
}
-(void)run{
    NSLog(@"weight is %d,age is %d",self.getAge,self.getWeight);
}
-(void)eat{
    NSLog(@"animal is eating");
}
@end
