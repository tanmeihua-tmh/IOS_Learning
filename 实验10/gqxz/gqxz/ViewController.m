//
//  ViewController.m
//  gqxz
//
//  Created by 王晨旭 on 2019/4/29.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import "ViewController.h"
#import "Flag.h"
@interface ViewController ()<UIPickerViewDataSource,UIPickerViewDelegate>
@property(nonatomic,strong)NSArray *flags;

@end

@implementation ViewController
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
     NSLog(@"%@",self.flags);
}


-(NSInteger)numberOfComponentsInPickerView:(nonnull UIPickerView *)pickerView {
        return 1;
}

- (NSInteger)pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSLog(@"flag num = %lu", (unsigned long)self.flags.count);
    return self.flags.count;
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
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
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 50;
}
@end
