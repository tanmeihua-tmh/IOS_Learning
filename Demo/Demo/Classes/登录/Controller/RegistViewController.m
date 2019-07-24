//
//  RegistViewController.m
//  Demo
//
//  Created by 王晨旭 on 2019/5/27.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import "RegistViewController.h"
#import "UserInfo.h"

@interface RegistViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *userNameTF;
@property (weak, nonatomic) IBOutlet UITextField *psdTF;

@end

@implementation RegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.userNameTF.delegate = self;
    self.psdTF.delegate = self;
    [self.userNameTF becomeFirstResponder];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)cancelClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)registClick:(UIButton *)sender {
    NSArray *userinfos = UserDefaultGet(@"allUserInfo");
    for (NSData *data in userinfos) {
        UserInfo *user = [NSKeyedUnarchiver unarchivedObjectOfClass:[UserInfo class] fromData:data error:nil];
        if ([user.userName isEqualToString:self.userNameTF.text]) {
            NSLog(@"账号已存在");
            return;
        }
    }
    NSArray *arr = UserDefaultGet(@"allUserInfo") == nil ? @[] : UserDefaultGet(@"allUserInfo");
    UserInfo *info = [UserInfo new];
    info.userName = self.userNameTF.text;
    info.password = self.psdTF.text;
    NSData *date = [NSKeyedArchiver archivedDataWithRootObject:info requiringSecureCoding:YES error:nil];
    NSArray *userInfos = [arr arrayByAddingObjectsFromArray:@[date]];
    UserDefaultSet(userInfos, @"allUserInfo");
    
    [self.view resignFirstResponder];
    !_block ? : _block(self.userNameTF.text);
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

// MARK: UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField == self.userNameTF) {
        if ([NSObject validateIsEmpty:textField.text]) {
            [SVProgressHUD showErrorWithStatus:@"不能为空"];
            return;
        }
        if (![NSObject validateEmail:textField.text] && ![NSObject validateMobile:textField.text]) {
            [SVProgressHUD showErrorWithStatus:@"请使用手机号或邮箱注册"];
            return;
        }
    }else {
        if (![NSObject validatePassword:textField.text]) {
            [SVProgressHUD showErrorWithStatus:@"请检查是否为6-20位字母和数字组成"];
            return;
        }
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
