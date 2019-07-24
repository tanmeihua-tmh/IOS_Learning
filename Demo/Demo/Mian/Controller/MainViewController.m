//
//  MainViewController.m
//  Demo
//
//  Created by 王晨旭 on 2019/5/26.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view adaptScreenWidthWithType:BSAdaptScreenWidthTypeAll exceptViews:nil];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view.
}

#pragma mark - Lazy
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.bounces = NO;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.estimatedRowHeight = 180;
        _tableView.rowHeight = UITableViewAutomaticDimension;
    }
    return _tableView;
}

- (void)dealloc
{
    [SVProgressHUD setAnimationDuration:0.01];
    [SVProgressHUD dismissWithDelay:0.01];
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
