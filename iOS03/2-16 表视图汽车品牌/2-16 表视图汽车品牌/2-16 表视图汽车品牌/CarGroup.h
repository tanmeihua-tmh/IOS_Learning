//
//  CarGroup.h
//  2-16 表视图汽车品牌
//
//  Created by wujz on 16/5/15.
//  Copyright © 2016年 zucc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CarGroup : NSObject
/**
 *  这组的标题
 */
@property (nonatomic, copy) NSString *title;
/**
 *  存放的所有的汽车品牌(里面装的都是MJCar模型)
 */
@property (nonatomic, strong) NSArray *cars;

+ (instancetype)groupWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
