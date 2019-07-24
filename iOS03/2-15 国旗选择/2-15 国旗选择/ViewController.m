//
//  ViewController.m
//  2-15 国旗选择
//
//  Created by wujz on 16/5/15.
//  Copyright © 2016年 zucc. All rights reserved.
//
//  注意：1、国旗图片文件路径；2、通过xib设置UI；3、字典转模型应用


#import "ViewController.h"
#import "Flag.h"

@interface ViewController () <UIPickerViewDataSource,UIPickerViewDelegate>
@property(nonatomic,strong)NSArray *flags;
@end

@implementation ViewController
//初始化时完成
-(NSArray *)flags{
    if (!_flags) {

        NSString *path = [[NSBundle mainBundle] pathForResource:@"flags.plist" ofType:nil];
        NSArray *flags = [NSArray arrayWithContentsOfFile:path];

        NSMutableArray *flagsM = [NSMutableArray array];
        for (NSDictionary *flagDict in flags) {
            Flag *flag = [Flag flagWithDict:flagDict];
            [flagsM addObject:flag];
        }

        _flags = flagsM;
    }

    return _flags;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    //
    NSLog(@"%@",self.flags);

//    NSArray *objs = [[NSBundle mainBundle] loadNibNamed:@"FlagView" owner:nil options:nil];
//    UIView *flagView = [objs lastObject];
//    [self.view addSubview:flagView];
//    NSLog(@"%@",objs);

}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    NSLog(@"flag num = %lu", (unsigned long)self.flags.count);
    return self.flags.count;
}


-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{

    //输入xib文件
    NSArray *objs = [[NSBundle mainBundle] loadNibNamed:@"FlagView" owner:nil options:nil];
    UIView *flagView = [objs lastObject];
    [pickerView addSubview:flagView];

    //国旗模型
    Flag *flag = self.flags[row];
    //设置国名
    UILabel *label = flagView.subviews[0];
    label.text = flag.name;

    //设置旗帜
    UIImageView *img = flagView.subviews[1];
    NSString *fileName = [NSString stringWithFormat:@"flag/%@", flag.icon];
    img.image = [UIImage imageNamed:fileName];

    return flagView;

}

//设置高度
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 50;
}

@end
