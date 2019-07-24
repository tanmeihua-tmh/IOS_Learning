//
//  Dog.h
//  ex04
//
//  Created by 王晨旭 on 2019/3/20.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Dog : NSObject
@property(nonatomic,readwrite) NSString* name;
-(void)bark;
@end

NS_ASSUME_NONNULL_END
