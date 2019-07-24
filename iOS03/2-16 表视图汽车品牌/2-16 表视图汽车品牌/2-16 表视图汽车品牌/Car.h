//
//  Car.h
//  2-16 表视图汽车品牌
//
//  Created by wujz on 16/5/15.
//  Copyright © 2016年 zucc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Car : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *icon;

+ (instancetype)carWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
