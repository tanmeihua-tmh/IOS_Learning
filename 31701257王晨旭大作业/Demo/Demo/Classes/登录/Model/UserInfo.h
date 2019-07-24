//
//  UserInfo.h
//  Demo
//
//  Created by 王晨旭 on 2019/5/27.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserInfo : NSObject<NSSecureCoding>

@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *password;

@end

NS_ASSUME_NONNULL_END
