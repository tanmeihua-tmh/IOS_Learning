//
//  DetailViewController.h
//  4-3 导航控制器(TableView)
//
//  Created by wujz on 16/5/22.
//  Copyright © 2016年 zucc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Book.h"

@interface DetailViewController : UIViewController
//@property (nonatomic, copy) NSString *lineNo;
@property (nonatomic, strong) Book *book;

@property (weak, nonatomic) IBOutlet UILabel *bookName;
@property (weak, nonatomic) IBOutlet UITextView *detailInfo;
@end
