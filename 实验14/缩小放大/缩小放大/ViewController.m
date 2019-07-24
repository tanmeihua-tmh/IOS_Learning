//
//  ViewController.m
//  缩小放大
//
//  Created by 王晨旭 on 2019/5/29.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(IBAction)pinch:(UIPinchGestureRecognizer *)sender {
    UIView *view = sender.view;
    view.transform = CGAffineTransformScale(view.transform, sender.scale, sender.scale);
    sender.scale = 1.0;
}

@end
