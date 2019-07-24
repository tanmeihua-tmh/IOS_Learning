//
//  EventTableViewCell.h
//  Demo
//
//  Created by 王晨旭 on 2019/5/27.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface EventTableViewCell : SCTEditTableViewCell

@property (nonatomic, strong) EventInfo *info;

@end

NS_ASSUME_NONNULL_END
