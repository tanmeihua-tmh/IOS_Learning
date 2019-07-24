//
//  MJLoginViewController.m
//  01-私人通讯录
//
//  Created by apple on 14-4-10.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "MJLoginViewController.h"
#import "MBProgressHUD+MJ.h"

#define MJAccountKey @"account"
#define MJPwdKey @"pwd"
#define MJRmbPwdKey @"rmb_pwd"
#define MJAutoLoginKey @"auto_login"

@interface MJLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *accountField;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UISwitch *rmbPwdSwitch;
- (IBAction)rmbPwdChange;
@property (weak, nonatomic) IBOutlet UISwitch *autoLoginSwitch;
- (IBAction)autoLoginChange;
- (IBAction)login;
@end

@implementation MJLoginViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.accountField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.pwdField];
    
    // 读取上次的配置
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.accountField.text = [defaults objectForKey:MJAccountKey];
    self.rmbPwdSwitch.on = [defaults boolForKey:MJRmbPwdKey];
    self.autoLoginSwitch.on = [defaults boolForKey:MJAutoLoginKey];
    
    // 处理密码
    if (self.rmbPwdSwitch.isOn) {
        self.pwdField.text = [defaults objectForKey:MJPwdKey];
    }
    
    // 处理自动登录的情况
    if (self.autoLoginSwitch.isOn) {
        [self login]; // 点击了"登录"按钮
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/**
 *  文本框的文字发生改变的时候调用
 */
- (void)textChange
{
    // 控制按钮的状态
//    if (self.accountField.text.length && self.pwdField.text.length) {
//        self.loginBtn.enabled = YES;
//    } else {
//        self.loginBtn.enabled = NO;
//    }
    self.loginBtn.enabled = (self.accountField.text.length && self.pwdField.text.length);
}

/**
 *  记住密码开关的状态改变就会调用
 */
- (IBAction)rmbPwdChange {
    // 取消了记住密码
    if (self.rmbPwdSwitch.isOn == NO) {
//        self.autoLoginSwitch.on = NO;
        [self.autoLoginSwitch setOn:NO animated:YES];
    }
}

/**
 *  自动登录的状态改变就会调用
 */
- (IBAction)autoLoginChange {
    if (self.autoLoginSwitch.isOn) {
//        self.rmbPwdSwitch.on = YES;
        [self.rmbPwdSwitch setOn:YES animated:YES];
    }
}

/**
 *  登录
 */
- (IBAction)login { // 帐号:mj  密码:123
    if (![self.accountField.text isEqualToString:@"mj"]) {
        // 帐号不存在
        [MBProgressHUD showError:@"帐号不存在"];
        return;
    }
    
    if (![self.pwdField.text isEqualToString:@"123"]) {
        // 密码错误
        [MBProgressHUD showError:@"密码错误"];
        return;
    }
    
    // 显示一个蒙版(遮盖)
    [MBProgressHUD showMessage:@"哥正在帮你登录中...."];
    
    // 发送网络请求
    
    // 模拟(1秒后执行跳转)
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 移除遮盖
        [MBProgressHUD hideHUD];
        
        // 跳转 -- 执行login2contacts这个segue
        [self performSegueWithIdentifier:@"login2contacts" sender:nil];
        
        // 存储数据
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:self.accountField.text forKey:MJAccountKey];
        [defaults setObject:self.pwdField.text forKey:MJPwdKey];
        [defaults setBool:self.rmbPwdSwitch.isOn forKey:MJRmbPwdKey];
        [defaults setBool:self.autoLoginSwitch.isOn forKey:MJAutoLoginKey];
        [defaults synchronize];
    });
}

/**
 *  执行segue后,跳转之前会调用这个方法
 *  一般在这里给下一个控制器传递数据
 */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // 1.取得目标控制器(联系人列表控制器)
    UIViewController *contactVc = segue.destinationViewController;
    
    // 2.设置标题
    contactVc.title = [NSString stringWithFormat:@"%@的联系人列表", self.accountField.text];
    // contactVc.title 等价于 contactVc.navigationItem.title
//    contactVc.navigationItem.title = [NSString stringWithFormat:@"%@的联系人列表", self.accountField.text];
}
@end
