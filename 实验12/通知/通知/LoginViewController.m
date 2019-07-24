//
//  LoginViewController.m
//  通知
//
//  Created by 王晨旭 on 2019/5/16.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()
#define UPDATE_LGOGIN_INFO_NOTIFICATION @"updateLoginInfo"
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
#pragma mark 登录操作
- (IBAction)login {
    if ([self.nameField.text isEqualToString:@"wcx"] && [self.passwordField.text isEqualToString:@"123456"] ) {
        [self.view endEditing:YES];
        [self postNotification];
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }else{
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"系统信息" message:@"用户名或密码错误，请重新输入！" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil];
        [alertView show];
    }
}
- (IBAction)cancel {
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)postNotification{
    NSDictionary *userInfo = @{@"loginInfo":[NSString stringWithFormat:@"Hello,%@!",self.nameField.text]};

    [[NSNotificationCenter defaultCenter] postNotificationName:UPDATE_LGOGIN_INFO_NOTIFICATION object:self userInfo:userInfo];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
