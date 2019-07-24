//
//  ViewController.m
//  喜马拉雅
//
//  Created by 王晨旭 on 2019/4/24.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *lastBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat contentX = 0;
    CGFloat contentY = CGRectGetMaxY(self.lastBtn.frame) + 10;
    self.scrollView.contentSize = CGSizeMake(contentX, contentY);

    CGFloat offsetX = 20;
    CGFloat offsetY = 30;
    self.scrollView.contentOffset = CGPointMake(offsetX, 0 - offsetY);

    self.scrollView.contentInset = UIEdgeInsetsMake(offsetY, 0, 50, 0);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
