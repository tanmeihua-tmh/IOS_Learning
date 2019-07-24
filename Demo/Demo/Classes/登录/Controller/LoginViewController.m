//
//  LoginViewController.m
//  Demo
//
//  Created by 王晨旭 on 2019/5/26.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import "LoginViewController.h"
#import "RegistViewController.h"
#import "UserInfo.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *userNameTF;
@property (weak, nonatomic) IBOutlet UITextField *psdTF;
@property (weak, nonatomic) IBOutlet UISwitch *rmbPwdSwitch;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"open"] forState:UIControlStateSelected];
    [btn setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 0, self.psdTF.height, self.psdTF.height);
    [btn addTarget:self action:@selector(hiddenOrDisplayClick:) forControlEvents:UIControlEventTouchUpInside];
    _psdTF.rightView = btn;
    _psdTF.rightViewMode = UITextFieldViewModeAlways;
    
    self.userNameTF.text = UserDefaultGet(@"userName");
    self.psdTF.text = [UserDefaultGet(@"remember") boolValue] ? UserDefaultGet(@"password") : @"";
    
}

- (void)hiddenOrDisplayClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.psdTF.secureTextEntry = !sender.selected;
}

- (IBAction)rememberPsdClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    UserDefaultSet([NSNumber numberWithBool:sender.selected], @"remember");
}

- (IBAction)loginClick:(UIButton *)sender {
    [self.view resignFirstResponder];
    [self.view endEditing:YES];
    
    if([self.userNameTF.text numberOfLengthBiggerThanZero] && ![self.userNameTF.text numberOfLengthBiggerThanZero]) {
        NSLog(@"请填写密码");
        [SVProgressHUD showErrorWithStatus:@"请填写密码"];
        return;
    }else if(![self.userNameTF.text numberOfLengthBiggerThanZero] && [self.userNameTF.text numberOfLengthBiggerThanZero]) {
        NSLog(@"请填写账号");
        [SVProgressHUD showErrorWithStatus:@"请填写账号"];
        return;
    }else if(![self.userNameTF.text numberOfLengthBiggerThanZero] && ![self.userNameTF.text numberOfLengthBiggerThanZero]){
        NSLog(@"请填写账号和密码");
        [SVProgressHUD showErrorWithStatus:@"请填写账号和密码"];
        return;
    }
    
    NSArray *userinfos = UserDefaultGet(@"allUserInfo");
    if (userinfos.count <= 0) {
        NSLog(@"账号不存在");
        [SVProgressHUD showErrorWithStatus:@"账号不存在,请注册"];
        return;
    }
    
    if ([self.userNameTF.text numberOfLengthBiggerThanZero]) {
        BOOL isExit = NO;
        UserInfo *user;
        for (NSData *data in userinfos) {
            user = [NSKeyedUnarchiver unarchivedObjectOfClass:[UserInfo class] fromData:data error:nil];
            if ([self.userNameTF.text isEqualToString:user.userName]) {
                isExit = YES;
                break;
            }
        }
        
        if (isExit) {
            if ([user.userName isEqualToString:self.userNameTF.text] && [user.password isEqualToString:self.psdTF.text]) {
                NSLog(@"登录成功");
                [SVProgressHUD showSuccessWithStatus:@"登录成功"];
                UserDefaultSet(self.userNameTF.text, @"userName");
                UserDefaultSet(self.psdTF.text, @"password");
                UserDefaultSet(@(YES), @"login");
                UIWindow *keywindow = [[UIApplication sharedApplication].delegate window];
                keywindow.rootViewController = [NSClassFromString(@"TabbarViewController") new];
            }else {
                NSLog(@"账号或密码错误");
                [SVProgressHUD showErrorWithStatus:@"账号或密码错误"];
            }
        }
        
        if (!isExit) {
            NSLog(@"账号不存在");
            [SVProgressHUD showErrorWithStatus:@"账号不存在,请注册"];
            return;
        }
    }
}

- (IBAction)registClick:(UIButton *)sender {
    [self.view resignFirstResponder];
    RegistViewController *registVC = [[RegistViewController alloc] init];
    registVC.block = ^(NSString * _Nonnull userName) {
        self.userNameTF.text = userName;
    };
    [self presentViewController:registVC animated:YES completion:^{
    }];
}
-(IBAction)rmbPwdChange{
    if (self.rmbPwdSwitch.isOn == NO) {
        //        self.autoLoginSwitch.on = NO;
      
    }
    
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
