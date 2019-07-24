//
//  main.m
//  消息通知
//
//  Created by 王晨旭 on 2019/5/15.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NewsCompany.h"
#import "Person.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NewsCompany *cctv = [[NewsCompany alloc] init];
        cctv.name = @"央视";
        
        NewsCompany *zjtv = [[NewsCompany alloc] init];
        zjtv.name = @"浙江电视台";
        Person *a = [[Person alloc] init];
        a.name = @"a";
        
        Person *b = [[Person alloc] init];
        b.name = @"b";
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        [center addObserver:a selector:@selector(newsCome:) name:@"junshidongtai" object:nil];
        [center addObserver:a selector:@selector(newsCome:) name:@"zhejiangxinwen" object:nil];
        [center addObserver:b selector:@selector(newsCome:) name:@"quanguoxinwen" object:nil];
        [center postNotificationName:@"junshidongtai" object:cctv userInfo:@{@"title" : @"伊拉克战争停止了",
                                                                             @"intro" : @"伊拉克战争停止了.........."}];
        [center postNotificationName:@"junshidongtai" object:zjtv userInfo:@{@"title" : @"浙江杭州",
                                                                             @"intro" : @"浙江杭州。。"}];
        [center postNotificationName:@"zhejiangxinwen" object:zjtv userInfo:@{@"title" : @"亚运会在杭州举行",
                                                                             @"intro" : @"亚运会在杭州。。。"}];
        [center postNotificationName:@"quanguoxinwen" object:cctv userInfo:@{@"title" : @"奥巴马访华",
                                                                             @"intro" : @"奥巴马访华。。。"}];
        
        
    }
    return 0;
}
