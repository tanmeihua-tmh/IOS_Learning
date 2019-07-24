//
//  Calculate.h
//  Demo
//
//  Created by 王晨旭 on 2019/5/30.
//  Copyright © 2019 王晨旭. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Calculate : NSObject

@property (nonatomic, assign) CGFloat result;

- (Calculate* (^)(CGFloat number))add;
- (Calculate* (^)(CGFloat number))minus;
- (Calculate* (^)(CGFloat number))multiply;
- (Calculate* (^)(CGFloat number))divide;

@end

NS_ASSUME_NONNULL_END
