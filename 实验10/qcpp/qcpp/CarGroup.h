//
//  CarGroup.h
//  qcpp
//
//  Created by 王晨旭 on 2019/5/2.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CarGroup : NSObject
@property (nonatomic, copy) NSString *title;
/**
 *  存放的所有的汽车品牌(里面装的都是MJCar模型)
 */
@property (nonatomic, strong) NSArray *cars;

+ (instancetype)groupWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
