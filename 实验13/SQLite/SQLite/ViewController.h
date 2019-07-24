//
//  ViewController.h
//  SQLite
//
//  Created by 王晨旭 on 2019/5/22.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *age;
@property (weak, nonatomic) IBOutlet UITextField *number;
@property (weak, nonatomic) IBOutlet UITextField *tname;
@property (weak, nonatomic) IBOutlet UITextField *tage;
@property (weak, nonatomic) IBOutlet UITextField *phonenum;
@property (weak, nonatomic) IBOutlet UITextField *course;

- (IBAction)save:(id)sender;
- (IBAction)read:(id)sender;
- (IBAction)readt:(id)sender;
- (IBAction)savet:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *readname;
@property (weak, nonatomic) IBOutlet UILabel *readage;


@end

