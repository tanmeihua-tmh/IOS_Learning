//
//  MJEditViewController.h
//  01-私人通讯录
//
//  Created by apple on 14-4-10.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MJContact, MJEditViewController;

@protocol MJEditViewControllerDelegate <NSObject>

@optional
- (void)editViewController:(MJEditViewController *)editVc didSaveContact:(MJContact *)contact;

@end

@interface MJEditViewController : UIViewController
@property (nonatomic, strong) MJContact *contact;

@property (nonatomic, weak) id<MJEditViewControllerDelegate> delegate;
@end
