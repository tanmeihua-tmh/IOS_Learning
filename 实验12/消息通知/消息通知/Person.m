//
//  Person.m
//  消息通知
//
//  Created by 王晨旭 on 2019/5/15.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import "Person.h"
#import "NewsCompany.h"
@implementation Person
- (void)newsCome:(NSNotification *)note
{
    // 通知的发布者
    NewsCompany *obj = note.object;
    
    NSLog(@"%@接收到了%@发出的通知,通知内容是:%@", self.name, obj.name, note.userInfo);
}

- (void)dealloc
{
    //    [super dealloc];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
