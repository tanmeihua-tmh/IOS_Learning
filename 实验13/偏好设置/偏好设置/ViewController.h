//
//  ViewController.h
//  偏好设置
//
//  Created by 王晨旭 on 2019/5/22.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UISwitch *UISwitch;
- (IBAction)login:(id)sender;


@end

