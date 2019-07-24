//
//  ViewController.m
//  2-5 UITextFiled应用
//
//  Created by wujz on 16/4/17.
//  Copyright © 2016年 zucc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 提示信息的方法
-(void)showMessage:(NSString *) message{

//    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:
//                        message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//    [alert show];


    // 准备初始化配置参数
    NSString *title = @"登录" ;
    //    NSString *message = @"I need your attention NOW!";
    NSString *okButtonTitle = @"确定";

    // 初始化
    UIAlertController *alertDialog = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];

    // 创建操作
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:okButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        // 操作具体内容
        // Nothing to do.
    }];

    // 添加操作
    [alertDialog addAction:okAction];

    // 呈现警告视图
    [self presentViewController:alertDialog animated:YES completion:nil];
}


- (IBAction)login:(id)sender {
    // 获取用户名
    NSString *username=self.username.text;
    // 获取密码
    NSString *password=self.password.text;
    // 判断用户名是否正确
    if ([username isEqualToString:@""]||[password isEqualToString:@""]) {
        [self showMessage:@"用户名或密码不能为空"];
    }
    else if([username isEqualToString:@"zucc"]&&[password isEqualToString:@"123456"]){
        [self showMessage:@"登录成功"];
    }
    else{
        [self showMessage:@"用户名或密码错误"];
    }
}
@end
