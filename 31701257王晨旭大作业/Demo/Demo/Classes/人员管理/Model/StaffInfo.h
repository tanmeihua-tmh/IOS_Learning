//
//  StaffInfo.h
//  Demo
//
//  Created by 王晨旭 on 2019/5/28.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface StaffInfo : NSObject<NSSecureCoding>

@property (nonatomic, copy) NSString *name;  // 姓名
@property (nonatomic, copy) NSString *studentNumber; // 学号
@property (nonatomic, copy) NSString *phoneNumber; // 手机号
@property (nonatomic, copy) NSString *QQNumber; // QQ号
@property (nonatomic, copy) NSString *WeChatNumber; // 微信号
@property (nonatomic, copy) NSString *emailNumber; // 邮箱号

@end

NS_ASSUME_NONNULL_END
