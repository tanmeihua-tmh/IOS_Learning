//
//  ViewController.m
//  qcpp
//
//  Created by 王晨旭 on 2019/5/2.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import "ViewController.h"
#import "CarGroup.h"
#import "Car.h"
@interface ViewController ()
@property (nonatomic, strong) NSArray *groups;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (NSArray *)groups
{
    if (_groups == nil) {
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"cars_total.plist" ofType:nil];
        NSArray *dictArray = [NSArray arrayWithContentsOfFile:path];
        
        NSMutableArray *groupArray = [NSMutableArray array];
        for (NSDictionary *dict in dictArray) {

            CarGroup *group = [CarGroup groupWithDict:dict];
            
            [groupArray addObject:group];
        }
        
        _groups = groupArray;
    }
    return _groups;
}
#pragma mark - 数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    CarGroup *group = self.groups[section];
    
    return group.cars.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"car";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }

    CarGroup *group = self.groups[indexPath.section];
    Car *car = group.cars[indexPath.row];
    
    cell.imageView.image = [UIImage imageNamed:car.icon];
    cell.textLabel.text = car.name;
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    CarGroup *group = self.groups[section];
    return group.title;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return [self.groups valueForKeyPath:@"title"];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}
@end
