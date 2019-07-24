//
//  ViewController.m
//  4-2导航控制器(值传递)
//
//  Created by wujz on 16/5/22.
//  Copyright © 2016年 zucc. All rights reserved.
//
/****************
 1、建立导航页面。利用segue进行参数传递
 2、在页面一和页面二放置UITextField和UILabel
 3、绑定页面class做新类OneViewController和TwoVoewController、并做IOOutLet
 4、在OneViewController中，使用方法：
    - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 5、在TwoViewController的- (void)viewDidLoad中显示参数
    self.disTxt.text = self.sendValue;
 ***************/

#import "ViewController.h"

@interface ViewController ()

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
