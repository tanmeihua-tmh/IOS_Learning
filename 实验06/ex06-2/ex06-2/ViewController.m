//
//  ViewController.m
//  ex06-2
//
//  Created by 王晨旭 on 2019/4/4.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.input becomeFirstResponder];
}


- (IBAction)click:(id)sender {
    NSString *str=self.input.text;
    self.output.text=[NSString stringWithFormat:@"hello %@",str];
    [self.input resignFirstResponder];
}
@end
