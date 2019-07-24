//
//  MainViewController.m
//  通知
//
//  Created by 王晨旭 on 2019/5/16.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()
#define UPDATE_LGOGIN_INFO_NOTIFICATION @"updateLoginInfo"
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.enterButton.layer.cornerRadius = 5;
    self.enterButton.clipsToBounds = YES;
}
- (IBAction)enter{
    [self addObserverToNotification];
    [self performSegueWithIdentifier:@"Main2Login" sender:nil];
}
-(void)addObserverToNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateLoginInfo:) name:UPDATE_LGOGIN_INFO_NOTIFICATION object:nil];
}
-(void)updateLoginInfo:(NSNotification *)notification{
    NSDictionary *userInfo = notification.userInfo;
    self.infoLabel.text = userInfo[@"loginInfo"];
    [self.enterButton setTitle:@"注销" forState:UIControlStateNormal];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
