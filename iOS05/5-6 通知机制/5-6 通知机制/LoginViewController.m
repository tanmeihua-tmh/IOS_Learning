//
//  LoginViewController.m
//  5-6 通知机制
//
//  Created by wujz on 16/5/28.
//  Copyright © 2016年 zucc. All rights reserved.
//

#import "LoginViewController.h"

#define UPDATE_LGOGIN_INFO_NOTIFICATION @"updateLoginInfo"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 让nameField成为第一响应者
    [self.nameField becomeFirstResponder];
}

#pragma mark 登录操作
// 点击“登录”按钮后执行的行为
- (IBAction)login {
    // 判断账号和密码信息是否正确
    if ([self.nameField.text isEqualToString:@"zucc"] && [self.passwordField.text isEqualToString:@"123456"] ) {
        // 退出键盘
        [self.view endEditing:YES];
        // 发送通知
        [self postNotification];
        // 关闭控制器
        [self dismissViewControllerAnimated:YES completion:nil];

    }else{
        //登录失败弹出提示信息
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"系统信息" message:@"用户名或密码错误，请重新输入！" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
        [alertView show];
    }
}

#pragma mark 点击取消
// 点击“取消”按钮后执行的行为
- (IBAction)cancel {
    // 退出键盘
    [self.view endEditing:YES];
    // 关闭控制器
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  添加通知，注意这里设置了附加信息
 */
-(void)postNotification{
    NSDictionary *userInfo = @{@"loginInfo":[NSString stringWithFormat:@"Hello,%@!",self.nameField.text]};
    // 发送带有附加信息的通知
    [[NSNotificationCenter defaultCenter] postNotificationName:UPDATE_LGOGIN_INFO_NOTIFICATION object:self userInfo:userInfo];
}
@end
