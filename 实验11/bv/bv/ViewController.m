//
//  ViewController.m
//  bv
//
//  Created by 王晨旭 on 2019/5/8.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"
#import "Book.h"
@interface ViewController () <UITableViewDelegate>
@property (nonatomic, strong) NSIndexPath *selectPath;

@property (nonatomic, copy) NSArray *books;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (NSArray *)books{
    if (!_books){
        _books = [Book books];
    }
    return _books;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //在导航线对象设置：@bookSegue
    [self performSegueWithIdentifier:@"bookSegue" sender:self];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    //  获取选择的索引行
    self.selectPath = [self.tableView indexPathForSelectedRow];
    //    NSLog(@"section = %ld, row = %ld",self.selectPath.section, self.selectPath.row);
    
    //获得当前选择图书的信息，包含名称、详情、图标
    Book *tmp = self.books[self.selectPath.row];
    NSLog(@"将被传送的数据%@",tmp);
    
    //此处的book为DetalViewController.h中的属性
    UIViewController *vc = segue.destinationViewController;
    if ([vc respondsToSelector:@selector(setBook:)]) {
        [vc setValue:tmp forKey:@"book"];
    }
    
    //    UIViewController *vc = segue.destinationViewController;
    //    if ([vc respondsToSelector:@selector(setLineNo:)]) {
    //        [vc setValue:tmp forKey:@"lineNo"];
    //    }
}
@end
