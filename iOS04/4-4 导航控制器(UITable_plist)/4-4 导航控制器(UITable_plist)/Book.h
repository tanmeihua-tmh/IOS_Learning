//
//  Book.h
//  4-4 导航控制器(UITable_plist)
//
//  Created by wujz on 16/5/22.
//  Copyright © 2016年 zucc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Book : UIViewController
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *detail;

- (instancetype) initWithDict:(NSDictionary *)dict;
+ (instancetype) bookWithDict:(NSDictionary *)dict;

+ (NSArray *)books;
@end
