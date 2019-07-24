//
//  ViewController.m
//  7-3 手势缩放(UIPinch)
//
//  Created by wujz on 16/6/11.
//  Copyright © 2016年 zucc. All rights reserved.
//
//  缩放时，两点应落在缩放区域内

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)pinch:(UIPinchGestureRecognizer *)sender {
    // 获取发生的视图
    UIView *view = sender.view;
    // 缩放
    view.transform = CGAffineTransformScale(view.transform, sender.scale, sender.scale);
    sender.scale = 1.0;
}

@end
