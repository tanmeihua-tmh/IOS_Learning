//
//  ViewController.m
//  4-3 导航控制器(TableView)
//
//  Created by wujz on 16/5/22.
//  Copyright © 2016年 zucc. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"

@interface ViewController () <UITableViewDelegate>
@property (nonatomic, strong) NSIndexPath *selectPath;

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

//  当选择一行时，跳转
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //在导航线对象设置：@bookSegue
    [self performSegueWithIdentifier:@"bookSegue" sender:self];
}

//  为数据传递使用
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    //  获取选择的索引行
    self.selectPath = [self.tableView indexPathForSelectedRow];
//    NSLog(@"section = %ld, row = %ld",self.selectPath.section, self.selectPath.row);

    NSString *tmp = [NSString stringWithFormat:@"%ld", (long)self.selectPath.row];
    NSLog(@"将被传送的数据%@",tmp);
    
    UIViewController *vc = segue.destinationViewController;
    if ([vc respondsToSelector:@selector(setLineNo:)]) {
        [vc setValue:tmp forKey:@"lineNo"];
    }
}
@end
