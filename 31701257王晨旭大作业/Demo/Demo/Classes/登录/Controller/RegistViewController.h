//
//  RegistViewController.h
//  Demo
//
//  Created by 王晨旭 on 2019/5/26.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import "MainViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^displayNewUserName)(NSString *userName);

@interface RegistViewController : MainViewController

@property (nonatomic, copy) displayNewUserName block;

@end

NS_ASSUME_NONNULL_END
