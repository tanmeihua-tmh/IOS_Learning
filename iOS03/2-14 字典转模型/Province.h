//
//  Province.h
//  2-14 字典转模型
//
//  Created by wujz on 16/5/15.
//  Copyright © 2016年 zucc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Province : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic,strong) NSArray *cities;

-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)provinceWithDict:(NSDictionary *)dict;
@end
