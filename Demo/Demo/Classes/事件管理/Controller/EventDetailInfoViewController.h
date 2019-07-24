//
//  EventDetailInfoViewController.h
//  Demo
//
//  Created by 王晨旭 on 2019/5/29.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import "MainViewController.h"
@class EventInfo;

typedef void(^changeInfo)(void);

NS_ASSUME_NONNULL_BEGIN

@interface EventDetailInfoViewController : MainViewController

@property (nonatomic, strong) EventInfo *info;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, copy) changeInfo block;

@end

NS_ASSUME_NONNULL_END
