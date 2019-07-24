//
//  Person.h
//  5-2 观察者模式(KVC)
//
//  Created by wujz on 16/5/28.
//  Copyright © 2016年 zucc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) int age;

@end
