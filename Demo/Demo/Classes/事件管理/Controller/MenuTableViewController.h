//
//  MenuTableViewController.h
//  Demo
//
//  Created by 王晨旭 on 2019/5/29.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^didSelected)(NSInteger index);

NS_ASSUME_NONNULL_BEGIN

@interface MenuTableViewController : UITableViewController
@property (nonatomic, strong) NSArray *lists;
@property (nonatomic, copy) didSelected block;

@end

NS_ASSUME_NONNULL_END
