//
//  JLViewController.m
//  03-省份城市联动
//
//  Created by 王晨旭 on 2019/4/24.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import "JLViewController.h"
#import "JLProvince.h"

@interface JLViewController ()<UIPickerViewDataSource, UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@property (weak, nonatomic) IBOutlet UILabel *provinceAndCityLabel;

@property (nonatomic, strong)NSArray *provinces;

@end

@implementation JLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    

    self.pickerView.dataSource = self;
   
    self.pickerView.delegate = self;

    [self pickerView:nil didSelectRow:0 inComponent:0];
}

- (NSArray *)provinces{

    if (_provinces == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"cities.plist" ofType:nil];
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:path];
        
        NSMutableArray *tempArray = [NSMutableArray array];

        for (NSDictionary *dict in dictArray) {
            JLProvince *province = [JLProvince provinceWithDict:dict];
            
            [tempArray addObject:province];
        }
        
        _provinces = tempArray;
    }
    
    return _provinces;
}

#pragma mark -数据源方法
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{

    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{

    if (0 == component) {
        
        return self.provinces.count;
    }

    int zeroRow = [self.pickerView selectedRowInComponent:0];

    JLProvince *province = self.provinces[zeroRow];

    return province.cities.count;
    
}

#pragma mark -代理方法

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{

    
    if (0 == component) {
        JLProvince *province = self.provinces[row];
        return province.name;
    }
    

    int zeroRow = [self.pickerView selectedRowInComponent:0];
    JLProvince *province = self.provinces[zeroRow];

    return province.cities[row];
    
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if (0 == component) {
        [self.pickerView reloadComponent:1];
        
        [self.pickerView selectRow:0 inComponent:1 animated:YES];
    }

    int zeroRow = [self.pickerView selectedRowInComponent:0];

    JLProvince *province = self.provinces[zeroRow];

    NSString *provinceName = province.name;
    
    int firstRow = [self.pickerView selectedRowInComponent:1];
    NSString *cityName = province.cities[firstRow];
    
    self.provinceAndCityLabel.text = [NSString stringWithFormat:@"%@--%@", provinceName, cityName];
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:self.provinceAndCityLabel.text];
    
    NSRange range = NSMakeRange(0, 2);
    [noteStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
}

@end
