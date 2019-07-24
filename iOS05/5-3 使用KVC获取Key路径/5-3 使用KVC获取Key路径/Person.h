//
//  Person.h
//  5-3 使用KVC获取Key路径
//
//  Created by wujz on 16/5/28.
//  Copyright © 2016年 zucc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Dog.h"

@interface Person : NSObject
// 定义三个属性，分别表示姓名、年龄、狗
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) int age;
@property (nonatomic, retain) Dog *dog;

@end
