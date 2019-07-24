//
//  ViewController.m
//  4-3 导航控制器(TableView)
//
//  Created by wujz on 16/5/22.
//  Copyright © 2016年 zucc. All rights reserved.
//
/*******************
1、改用plist中读取图书信息，使用字典转模型
2、定义Book类

*******************/


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
    // Do any additional setup after loading the view, typically from a nib.
}

- (NSArray *)books{
    if (!_books){
        _books = [Book books];
    }
    return _books;
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
