//
//  OneViewController.m
//  4-2导航控制器(值传递)
//
//  Created by wujz on 16/5/21.
//  Copyright © 2016年 zucc. All rights reserved.
//

#import "OneViewController.h"
#import "TwoViewController.h"

@interface OneViewController ()

@end

@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
/*  通过segue进行页面间的数据传递
    在第二个页面中，添加属性sendValue
    下面方法中：respondsToSelector:@selector(setSendValue:)
            setValue:dat forKey:@"SendValue"
    本质上使用了set方法
 */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSString *dat = self.myOneTxt.text;
    UIViewController *vc = segue.destinationViewController;
    if ([vc respondsToSelector:@selector(setSendValue:)]) {
        [vc setValue:dat forKey:@"sendValue"];
    }
}

@end
