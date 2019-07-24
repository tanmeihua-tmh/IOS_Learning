//
//  ViewController.h
//  6-4 偏好设置保存密码
//
//  Created by wujz on 16/6/4.
//  Copyright © 2016年 zucc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UISwitch *rememberSwitch;

- (IBAction)login:(id)sender;

@end

