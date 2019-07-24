//
//  ViewController.m
//  2-2 UILabel使用代码创建
//
//  Created by wujz on 16/4/17.
//  Copyright © 2016年 zucc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.


    [self creatLabelByCode];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//通过代码创建标签控件
- (void)creatLabelByCode {
    // 1.初始化标签控件
    UILabel *label = [[UILabel alloc] init];

    // 2.设置标签控件的frame
    CGFloat labelX = 0; // X值为0
    CGFloat labelY = 210; // Y值为210
    CGFloat labelW = self.view.bounds.size.width; //width值为屏幕宽度
    CGFloat labelH = 120;  // height值为40
    CGRect frame = CGRectMake(labelX, labelY, labelW, labelH);
    label.frame = frame;

    // 3.设置背景颜色为灰色
//    label.backgroundColor = [UIColor lightGrayColor];
    label.backgroundColor = [UIColor colorWithRed:240/255.0 green:0/255.0 blue:240/255.0 alpha:1];

    // 4.设置字体和字体颜色
    label.text = @"Welcome to ZUCC";
    label.font = [UIFont fontWithName:@"Helvetica-Bold" size:40];
    label.textColor = [UIColor whiteColor];

    // 4.设置对齐方式为居中
    label.textAlignment = NSTextAlignmentCenter;

    // 5.设置阴影
    label.shadowColor = [UIColor colorWithWhite:0.1f alpha:0.8f];
    label.shadowOffset = CGSizeMake(2, 3);

    // 6.设置换行
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.numberOfLines = 2;

    // 显示到UIView
    [self.view addSubview:label];
}

@end
