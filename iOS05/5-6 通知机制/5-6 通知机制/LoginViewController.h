//
//  LoginViewController.h
//  5-6 通知机制
//
//  Created by wujz on 16/5/28.
//  Copyright © 2016年 zucc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
// 定义两个属性，分别表示账号文本框和密码文本框
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@end
