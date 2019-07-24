//
//  Flag.h
//  2-15 国旗选择
//
//  Created by wujz on 16/5/15.
//  Copyright © 2016年 zucc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Flag : NSObject
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *icon;

-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)flagWithDict:(NSDictionary *)dict;
@end
