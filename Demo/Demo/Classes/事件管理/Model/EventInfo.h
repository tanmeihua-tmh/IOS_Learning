//
//  EventInfo.h
//  Demo
//
//  Created by 王晨旭 on 2019/5/27.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EventInfo : NSObject<NSSecureCoding>
// 事件名称
@property (nonatomic, copy) NSString *title;
// 事件简介
@property (nonatomic, copy) NSString *descript;
// 事件详情
@property (nonatomic, copy) NSString *detailInfo;
// 事件结束时间
@property (nonatomic, strong) NSDate *endTime;

@end

NS_ASSUME_NONNULL_END
