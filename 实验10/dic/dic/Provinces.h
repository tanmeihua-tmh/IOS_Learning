//
//  Provinces.h
//  dic
//
//  Created by 王晨旭 on 2019/4/29.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Provinces : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic,strong) NSArray *cities;

-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)provinceWithDict:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
