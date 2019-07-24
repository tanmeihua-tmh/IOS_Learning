//
//  MJAddViewController.h
//  01-私人通讯录
//
//  Created by apple on 14-4-10.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MJAddViewController, MJContact;

@protocol MJAddViewControllerDelegate <NSObject>

@optional
//- (void)addViewController:(MJAddViewController *)addVc didAddContactWithName:(NSString *)name phone:(NSString *)phone;
- (void)addViewController:(MJAddViewController *)addVc didAddContact:(MJContact *)contact;
@end

@interface MJAddViewController : UIViewController
@property (nonatomic, weak) id<MJAddViewControllerDelegate> delegate;
@end
