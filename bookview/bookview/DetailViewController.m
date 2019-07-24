//
//  DetailViewController.m
//  bookview
//
//  Created by 王晨旭 on 2019/5/8.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"传递过来的行号 = %lu", self.lineNo.integerValue);
    self.bookName.text = [NSString stringWithFormat:@"%ld", self.lineNo.integerValue];
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
