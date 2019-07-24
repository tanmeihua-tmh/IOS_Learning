//
//  JLProvince.h
//  03-省份城市联动
//
//  Created by 王晨旭 on 2019/4/24.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JLProvince : NSObject
/**
 *  省份名称
 */
@property (nonatomic, copy)NSString *name;
/**
 *  该省中所有的城市
 */
@property (nonatomic, strong)NSArray *cities;

- (instancetype)initWithDict:(NSDictionary *)dict;

+ (instancetype)provinceWithDict:(NSDictionary *)dict;

@end
