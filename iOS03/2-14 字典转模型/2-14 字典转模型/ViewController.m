//
//  ViewController.m
//  2-14 字典转模型
//
//  Created by wujz on 16/5/15.
//  Copyright © 2016年 zucc. All rights reserved.
//

#import "ViewController.h"
#import "province.h"

@interface ViewController ()
@property (nonatomic, strong) NSArray *provinces;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    NSLog(@"%@",self.provinces);
//    for (NSDictionary *dict in self.provinces) {
//        NSLog(@"%@",dict);
//    }
}

/**
 *懒加载数据
 */
-(NSArray *)provinces{
    if (!_provinces) {

        //plist文件路径
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"provinces.plist" ofType:nil];
        NSArray *provincePlist = [NSArray arrayWithContentsOfFile:filePath];

        NSMutableArray *provinceM = [NSMutableArray array];
        for (NSDictionary *dict in provincePlist) {
            Province *prov = [Province provinceWithDict:dict];
            [provinceM addObject:prov];
        }

        _provinces = provinceM;
    }

    return _provinces;
}
@end
