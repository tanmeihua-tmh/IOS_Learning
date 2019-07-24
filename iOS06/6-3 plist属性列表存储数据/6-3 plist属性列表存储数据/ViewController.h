//
//  ViewController.h
//  6-3 plist属性列表存储数据
//
//  Created by wujz on 16/6/4.
//  Copyright © 2016年 zucc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *birthdayField;
@property (weak, nonatomic) IBOutlet UISegmentedControl *sexSegment;
@property (weak, nonatomic) IBOutlet UITextField *numberField;
- (IBAction)saveBtn:(id)sender;

@end

