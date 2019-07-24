//
//  ViewController.m
//  7-4 手势粘合
//
//  Created by wujz on 16/6/11.
//  Copyright © 2016年 zucc. All rights reserved.
//
//  UIImageView 设置可用户交互、允许多点触摸。

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 初始化一个捏合手势识别器
    UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
    // 把手势识别器添加到图像视图
    [self.imageView addGestureRecognizer:pinchGesture];
}

/** 检测到捏合手势后回调的方法*/
- (void)pinch:(UIPinchGestureRecognizer *)recognizer
{
    // 获取手势发生的视图
    UIView *view = recognizer.view;
    // 叠加缩放图像
    view.transform = CGAffineTransformScale(view.transform, recognizer.scale, recognizer.scale);
    // 每次形变之后，将当前的大小作为初始比例
    recognizer.scale = 1.0;
}

@end