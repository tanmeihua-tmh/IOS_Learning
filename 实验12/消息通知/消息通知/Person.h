//
//  Person.h
//  消息通知
//
//  Created by 王晨旭 on 2019/5/15.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject
@property (nonatomic, copy) NSString *name;

- (void)newsCome:(NSNotification *)note;
@end

NS_ASSUME_NONNULL_END
