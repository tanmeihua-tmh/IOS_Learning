//
//  main.m
//  5-5 通知中心
//
//  Created by wujz on 16/5/29.
//  Copyright © 2016年 zucc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import "NewsCompany.h"

int main(int argc, const char * argv[])
{
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");

        // 1.初始化机构
        NewsCompany *tx = [[NewsCompany alloc] init];
        tx.name = @"腾讯新闻";

        NewsCompany *sina = [[NewsCompany alloc] init];
        sina.name = @"新浪新闻";

        // 2.初始化3个人
        Person *zhangsan = [[Person alloc] init];
        zhangsan.name = @"张三";

        Person *lisi = [[Person alloc] init];
        lisi.name = @"李四";

        Person *wangwu = [[Person alloc] init];
        wangwu.name = @"王五";

        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        // 3.添加监听器
        // zhangsan只监听tx发出的junshi_news_come通知
        // 2
        [center addObserver:zhangsan selector:@selector(newsCome:) name:@"junshi_news_come" object:nil];
        [center addObserver:zhangsan selector:@selector(newsCome:) name:@"yule_news_come" object:nil];
        // 1
        [center addObserver:lisi selector:@selector(newsCome:) name:nil object:tx];
        // 2
        [center addObserver:wangwu selector:@selector(newsCome:) name:nil object:nil];

        // 4.发布新闻

        // tx发布了一则叫做junshi_news_come的通知
        [center postNotificationName:@"junshi_news_come"
                              object:tx
                            userInfo:@{@"title" : @"伊拉克战争停止了",
                                       @"intro" : @"伊拉克战争停止了.........."}];

        // sina发布了一则叫做junshi_news_come的通知
        [center postNotificationName:@"yule_news_come"
                              object:sina
                            userInfo:@{@"title" : @"6456456456456",
                                       @"intro" : @"7657567567567"}];
    }
    return 0;
}
