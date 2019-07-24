//
//  TabbarViewController.m
//  Demo
//
//  Created by 王晨旭 on 2019/5/26.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import "TabbarViewController.h"
#import "NavigationViewController.h"
#import "StaffViewController.h"
#import "EventViewController.h"
#import "SetupViewController.h"

@interface TabbarViewController ()

@end

@implementation TabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addChildViewController:[EventViewController new] title:@"事件管理" imageName:@"event"];
    [self addChildViewController:[StaffViewController new] title:@"人员管理" imageName:@"staff"];
    [self addChildViewController:[SetupViewController new] title:@"设置" imageName:@"setup"];
}

- (void)addChildViewController:(UIViewController *)childController title:(NSString *)title imageName:(NSString *)imageName {
    
    childController.title = title;
    [childController.tabBarItem setImage:[[UIImage imageNamed:[NSString stringWithFormat:@"%@_normal",imageName]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [childController.tabBarItem setSelectedImage:[[UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",imageName]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    NavigationViewController *nav = [[NavigationViewController alloc] initWithRootViewController:childController];
    [self addChildViewController:nav];
    
}

@end
