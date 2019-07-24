//
//  ViewController.h
//  ex06-2
//
//  Created by 王晨旭 on 2019/4/4.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

- (IBAction)click:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *input;
@property (weak, nonatomic) IBOutlet UILabel *output;

@end

