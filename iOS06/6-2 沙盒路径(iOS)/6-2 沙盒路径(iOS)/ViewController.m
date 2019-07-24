//
//  ViewController.m
//  6-2 沙盒路径(iOS)
//
//  Created by wujz on 16/6/4.
//  Copyright © 2016年 zucc. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    //获取应用程序的路径
    NSString *appPath = NSHomeDirectory();
    NSLog(@"沙盒路径：%@", appPath);

    //获取document文件夹路径
    NSArray *array = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docPath = [array objectAtIndex:0];
    NSLog(@"Document 路径：%@", docPath);

    //获取tmp的路径
    NSString *tmpPath = NSTemporaryDirectory();
    NSLog(@"tmp路径：%@", tmpPath);

    //获取Library的路径
    NSArray *libArray = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *libPath = [libArray objectAtIndex:0];
    NSLog(@"Library 路径：%@", libPath);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
