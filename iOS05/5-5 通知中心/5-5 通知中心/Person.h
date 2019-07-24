//
//  Person.h
//  5-5 通知中心
//
//  Created by wujz on 16/5/29.
//  Copyright © 2016年 zucc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject
/**
 * 姓名
 */
@property (nonatomic, copy) NSString *name;

- (void)newsCome:(NSNotification *)note;
@end
