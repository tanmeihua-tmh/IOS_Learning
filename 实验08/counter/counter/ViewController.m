//
//  ViewController.m
//  counter
//
//  Created by 王晨旭 on 2019/4/17.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIDatePicker *datepicker;
- (IBAction)click:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btn_start;

@end

@implementation ViewController
NSTimer *timer;
NSTimeInterval lefttime;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (IBAction)click:(id)sender {
    lefttime=self.datepicker.countDownDuration;
    self.datepicker.userInteractionEnabled=NO;
    [sender setEnabled:NO];
    NSString *msg=[NSString stringWithFormat:@"您还剩下【%f】秒",lefttime];
    UIAlertController *alertC=[UIAlertController alertControllerWithTitle:@"开始倒计时" message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *certain=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alertC addAction:certain];
    [self presentViewController:alertC animated:YES completion:nil];
    timer=[NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(tickDown) userInfo:nil repeats:YES];
    
}
-(void)tickDown{
    lefttime-=60;
    self.datepicker.countDownDuration=lefttime;
    if(lefttime<=0){
        [timer invalidate];
        self.datepicker.userInteractionEnabled=YES;
        self.btn_start.enabled=YES;
        UIAlertController *alertC=[UIAlertController alertControllerWithTitle:@"时间到" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *certain=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [alertC addAction:certain];
        [self presentViewController:alertC animated:YES completion:nil];
    }
}
@end
