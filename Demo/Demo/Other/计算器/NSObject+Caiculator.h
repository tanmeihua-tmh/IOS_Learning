//
//  NSObject+Caiculator.h
//  Demo
//
//  Created by 王晨旭 on 2019/5/30.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Calculate.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Caiculator)

- (CGFloat)makeCalculateMethod:(void(^)(Calculate *calculator)) block;

@end

NS_ASSUME_NONNULL_END
