//
//  ViewController.m
//  7-1 多点触摸
//
//  Created by wujz on 16/6/11.
//  Copyright © 2016年 zucc. All rights reserved.
//
//  需要设置：View-->属性检查器-->勾选 Multiple Touch


#import "ViewController.h"

@interface ViewController ()
// 定义一个数组保存图片
@property (nonatomic, strong) NSArray *icons;
@end

@implementation ViewController
#pragma mark - 懒加载数组
- (NSArray *)icons
{
    if (!_icons) {
        // 快速包装一个装有两个图片对象的数组
        _icons = @[[UIImage imageNamed:@"spark_blue"], [UIImage imageNamed:@"spark_cyan"]];
    }
    return _icons;
}


- (void)viewDidLoad {
    [super viewDidLoad];
}

///** 触摸开始的方法*/
//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    // 绘制图像
//    [self drawImageWithTouches:touches];
//}

/**  触摸移动的方法*/
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 绘制图像
    [self drawImageWithTouches:touches];
}


/** 抽取的绘制图像的方法*/
- (void)drawImageWithTouches:(NSSet *)touches
{
    // 定义一个索引值
    int i = 0;
    // 遍历集合，取出所有的触屏对象
    for (UITouch *touch in touches) {
        // 获取触摸点的位置
        CGPoint location = [touch locationInView:self.view];
        // 添加一个imageView放置图片
        UIImageView *imageView = [[UIImageView alloc] initWithImage:self.icons[i]];
        // 设置imageView的中心点为触摸点
        imageView.center = location;
        [self.view addSubview:imageView];
        // 增加索引值
        i++;
        // 添加一个动画，将imageView从父视图删除
        [UIView animateWithDuration:3.0f animations:^{
            imageView.alpha = 0.0f; // 降低透明度
        }completion:^(BOOL finished) {
            [imageView removeFromSuperview]; // 移除imageView
        }];
    }
}

@end
