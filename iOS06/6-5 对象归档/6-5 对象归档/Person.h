//
//  Person.h
//  6-5 对象归档
//
//  Created by wujz on 16/6/4.
//  Copyright © 2016年 zucc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject<NSCoding>

@property(nonatomic,copy)NSString *name;
@property(nonatomic, assign) int age;
@property(nonatomic, assign) float height;
@property(nonatomic, assign) float weight;

@end
