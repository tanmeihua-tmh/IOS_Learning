//
//  TwoViewController.h
//  4-2导航控制器(值传递)
//
//  Created by wujz on 16/5/21.
//  Copyright © 2016年 zucc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TwoViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *disTxt;
@property (nonatomic, copy) NSString *sendValue;

@end
