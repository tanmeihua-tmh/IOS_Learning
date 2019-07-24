//
//  ViewController.m
//  UITextField
//
//  Created by 王晨旭 on 2019/4/10.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
- (IBAction)username:(UITextField *)sender;
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;
- (IBAction)login:(id)sender;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)showMessage:(NSString *) message{

    NSString *title = @"登录" ;
    //    NSString *message = @"I need your attention NOW!";
    NSString *okButtonTitle = @"确定";
    UIAlertController *alertDialog = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
  
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:okButtonTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {

    }];

    [alertDialog addAction:okAction];
 
    [self presentViewController:alertDialog animated:YES completion:nil];
}
- (IBAction)login:(id)sender {
    NSString *username=self.username.text;

    NSString *password=self.password.text;
    if ([username isEqualToString:@""]||[password isEqualToString:@""]) {
        [self showMessage:@"用户名或密码不能为空"];
    }
    else if([username isEqualToString:@"zucc"]&&[password isEqualToString:@"123456"]){
        [self showMessage:@"登录成功"];
    }
    else{
        [self showMessage:@"用户名或密码错误"];
}
}
@end
