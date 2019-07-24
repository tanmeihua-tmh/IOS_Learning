//
//  DetailViewController.m
//  4-3 导航控制器(TableView)
//
//  Created by wujz on 16/5/22.
//  Copyright © 2016年 zucc. All rights reserved.
//

#import "DetailViewController.h"
#import "Book.h"

@interface DetailViewController ()
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    NSLog(@"传递过来的行号 = %lu", self.lineNo.integerValue);
//    self.bookName.text = [NSString stringWithFormat:@"%ld", self.lineNo.integerValue];
//    self.bookName.text = [NSString stringWithFormat:@"%@", book.name];
    self.bookName.text = self.book.name;
    self.detailInfo.text = self.book.detail;

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

@end
