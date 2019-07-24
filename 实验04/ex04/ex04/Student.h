//
//  Student.h
//  ex04
//
//  Created by 王晨旭 on 2019/3/20.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Agency;
NS_ASSUME_NONNULL_BEGIN

@interface Student : NSObject
-(void)findhouse;
@property(nonatomic,readwrite)NSString* name;
@property(nonatomic,strong)Agency *delegate;
@end

NS_ASSUME_NONNULL_END
