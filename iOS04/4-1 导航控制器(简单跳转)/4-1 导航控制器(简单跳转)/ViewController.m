//
//  ViewController.m
//  4-1 导航控制器(简单跳转)
//
//  Created by wujz on 16/5/21.
//  Copyright © 2016年 zucc. All rights reserved.
//
/***************************************************************
 1、建立连个UIViewController
 2、通过导航实现简单调转
 3、修改相关属性
***************************************************************/

#import "ViewController.h"
#import "OneViewController.h"
#import "TwoViewController.h"

@interface ViewController ()
@property (nonatomic, copy) NSString *inTxt;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
