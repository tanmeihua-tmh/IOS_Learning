//
//  ViewController.m
//  6-4 偏好设置保存密码
//
//  Created by wujz on 16/6/4.
//  Copyright © 2016年 zucc. All rights reserved.
//

#import "ViewController.h"

#define FileName @"itcast.UserLogin.plist"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // 判断是否存在保存偏好设置的文件
    NSFileManager *manager=[NSFileManager defaultManager];
    if ([manager fileExistsAtPath:[self filePath]]) {
        // 创建NSUserDefaults实例对象
        NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
        NSString *name=[user objectForKey:@"Name"];
        NSString *password=[user objectForKey:@"Password"];
        BOOL remember=[[user objectForKey:@"isRemember"]boolValue];

        // 显示到界面中
        self.nameField.text=name;
        if (remember) {
            self.passwordField.text=password;
        }
        [self.rememberSwitch setOn:remember];

    }
}

// 获取路径FileName文件的路径的方法
-(NSString *)filePath
{
    NSArray *array = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *path = [array objectAtIndex:0];
    NSString *finalPath = [path stringByAppendingPathComponent:@"Preferences"];
    return [finalPath stringByAppendingPathComponent:FileName];
}

// 屏幕单击事件响应
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES]; // 退出键盘
}

- (IBAction)login:(id)sender {
    NSString *name=self.nameField.text;
    NSString *password=self.passwordField.text;
    NSNumber *remember=[NSNumber numberWithBool:self.rememberSwitch.on];

    if (!name.length||!password.length) {
        [self alertViewWithTitle:@"提示" message:@"账号和密码不能为空！"CertainButtonTitle:@"确定"];
        return;
    }
    // 创建NSUserDefaults对象，并保存数据
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    [user setObject:name forKey:@"Name"];
    [user setObject:password forKey:@"Password"];
    [user setObject:remember forKey:@"isRemember"];

    // 立即保存信息
    [user synchronize];
    [self alertViewWithTitle:@"提示" message:@"登录成功"CertainButtonTitle:@"确定"];
}

// 定义一个提示用户信息的方法
//    UIAlertView 已经被废弃，不再使用
-(void)alertViewWithTitle:(NSString *)title message:(NSString *)message CertainButtonTitle:(NSString *)buttonTitle{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title              message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *defult = [UIAlertAction actionWithTitle:buttonTitle style:UIAlertActionStyleDefault handler:nil];

    [alert addAction:defult];
    //显示
    [self presentViewController:alert animated:YES completion:nil];
    
}

@end
