//
//  ViewController.m
//  7-2 轻扫手势
//
//  Created by wujz on 16/6/11.
//  Copyright © 2016年 zucc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

// 定义两个属性，分别表示向左轻扫和向右轻扫手势识别器
@property (nonatomic, strong) UISwipeGestureRecognizer *swipeLeft;
@property (nonatomic, strong) UISwipeGestureRecognizer *swipeRight;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 初始化左侧和右侧方向轻扫手势识别器
    self.swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    self.swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];

    // 把两个手势识别器添加到主视图
    [self.view addGestureRecognizer:self.swipeLeft];
    [self.view addGestureRecognizer:self.swipeRight];

    // 设置识别器检测的轻扫方向
    self.swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    self.swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
}

/** 检测到轻扫手势回调的方法*/
- (void)swipe:(UISwipeGestureRecognizer *)recognizer
{
    // 获取手势的触摸点
    CGPoint location = [recognizer locationInView:self.view];

    // 设置图片的内容
    self.emotionView.image = [UIImage imageNamed:@"emotion"];

    // 设置图片的初始位置
    self.emotionView.center = location;

    // 设置图片的透明度
    self.emotionView.alpha = 1.0;
    // 检测当前手势的方向是向左还是向右
    if (recognizer.direction == UISwipeGestureRecognizerDirectionLeft) {
        location.x -= 150.0;
    }else{
        location.x += 150.0;
    }

    // 添加动画
    [UIView animateWithDuration:0.6f animations:^{
        // 设置图片的透明度和移动的位置
        self.emotionView.alpha = 0.0;
        self.emotionView.center = location;
    }];
}
@end

