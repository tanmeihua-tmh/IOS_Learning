//
//  Flag.h
//  gqxz
//
//  Created by 王晨旭 on 2019/4/29.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Flag : NSObject
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *icon;

-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)flagWithDict:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
