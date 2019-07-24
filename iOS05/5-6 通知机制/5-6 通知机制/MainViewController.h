//
//  MainViewController.h
//  5-6 通知机制
//
//  Created by wujz on 16/5/28.
//  Copyright © 2016年 zucc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController
// 定义两个属性，表示信息标签和进入按钮
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;

@property (weak, nonatomic) IBOutlet UIButton *enterButton;

@end
