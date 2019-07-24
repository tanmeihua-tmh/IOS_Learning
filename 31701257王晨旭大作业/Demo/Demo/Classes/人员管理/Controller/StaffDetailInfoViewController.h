//
//  StaffDetailInfoViewController.h
//  Demo
//
//  Created by 王晨旭 on 2019/5/28.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import "MainViewController.h"
#import "StaffInfo.h"
typedef void(^changeInfo)(void);
NS_ASSUME_NONNULL_BEGIN

@interface StaffDetailInfoViewController : MainViewController

@property (nonatomic, strong) StaffInfo *info;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, copy) changeInfo block;

@end

NS_ASSUME_NONNULL_END
