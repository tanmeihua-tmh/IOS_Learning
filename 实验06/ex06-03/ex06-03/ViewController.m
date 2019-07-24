//
//  ViewController.m
//  ex06-03
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
    [self.input1 becomeFirstResponder];
}


- (IBAction)qingling:(id)sender {
    symbol=NULL;
    _num1=0;
    _num2=0;
    self.output.text=@"0";
}

- (IBAction)cunchu:(id)sender {
    NSString *num1str=self.input1.text;
    NSString *num2str=self.input3.text;
    _num1=[num1str intValue];
    _num2=[num2str intValue];
    symbol=self.input2.text;
}

- (IBAction)duqu:(id)sender {
    NSString *num1str=self.input1.text;
    NSString *num2str=self.input3.text;
    _num1=[num1str doubleValue];
    _num2=[num2str doubleValue];
    symbol=self.input2.text;
}

- (IBAction)dengyu:(id)sender {
    double sum;
    if([symbol isEqual:@"-"]){
        sum=_num1-_num2;
    }
    else if ([symbol isEqual:@"+"]) {
        sum=_num1+_num2;
    }
    else if([symbol isEqual:@"*"]){
        sum=_num1*_num2;
    }
    else{
        sum=_num1/_num2;
    }
    self.output.text=[NSString stringWithFormat:@"%.05f",sum];
    [self.input1 resignFirstResponder];
    [self.input2 resignFirstResponder];
    [self.input3 resignFirstResponder];
}
@end
