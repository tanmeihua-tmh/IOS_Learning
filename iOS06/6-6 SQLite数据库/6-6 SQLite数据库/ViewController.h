//
//  ViewController.h
//  6-6 SQLite数据库
//
//  Created by wujz on 16/6/4.
//  Copyright © 2016年 zucc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *age;
@property (weak, nonatomic) IBOutlet UITextField *number;

- (IBAction)save:(UIButton *)sender;
- (IBAction)selectD:(id)sender;

@end

