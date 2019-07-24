//
//  MainViewController.m
//  5-6 通知机制
//
//  Created by wujz on 16/5/28.
//  Copyright © 2016年 zucc. All rights reserved.
//
//  1、注意类的绑定
//  2、标识符Identity的设置：点击两视图之间的连线，在属性检查器中

#import "MainViewController.h"

// 定义一个宏，表示通知的名称
#define UPDATE_LGOGIN_INFO_NOTIFICATION @"updateLoginInfo"

@interface MainViewController ()

@end

@implementation MainViewController
// 点击“进入“按钮后执行的行为
- (IBAction)enter{
    // 添加一个监听器
    [self addObserverToNotification];
    // 跳转到标识为Main2Login的目标控制器
    [self performSegueWithIdentifier:@"Main2Login" sender:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 按钮设置为圆角
    self.enterButton.layer.cornerRadius = 5;
    self.enterButton.clipsToBounds = YES;
}

/**
 *  添加监听器的方法
 */
-(void)addObserverToNotification{
    // 通知中心调用addObserver方法注册一个监听器
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateLoginInfo:) name:UPDATE_LGOGIN_INFO_NOTIFICATION object:nil];
}

/**
 *  更新登录信息,注意在这里可以获得通知对象并且读取附加信息
 */
-(void)updateLoginInfo:(NSNotification *)notification{
    // 获取通知的额外信息
    NSDictionary *userInfo = notification.userInfo;
    // 将额外信息的内容显示到titleLabel
    self.infoLabel.text = userInfo[@"loginInfo"];
    // 更改按钮的标题
    [self.enterButton setTitle:@"注销" forState:UIControlStateNormal];
}

-(void)dealloc{
    //移除监听
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
