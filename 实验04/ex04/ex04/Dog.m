//
//  Dog.m
//  ex04
//
//  Created by 王晨旭 on 2019/3/20.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import "Dog.h"
@interface Dog()
@property(nonatomic,readwrite)int volume;
-(void)wagTailteach;
@end
@implementation Dog
-(void)wagTailteach{
    self.volume=1;
    NSLog(@"volume is %d",self.volume);
    NSLog(@"wagTailteach");
    NSLog(@"dog's name is %@",self.name );
}
-(void)bark{
    [self wagTailteach];
    NSLog(@"The dog is barking");
}
@end
